Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>, Jean Pihet <j-pihet@ti.com>,
	linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	mark gross <markgross@thegnar.org>
Subject: Re: [RFD][PATCH 5/7] PM / QoS: Make it possible to expose PM QoS device flags to user space
Date: Tue, 30 Oct 2012 16:29:07 +0100
Message-ID: <3050749.si8v66pygi@vostro.rjw.lan>
In-Reply-To: <508F9588.5040105@intel.com>
References: <201209282351.10663.rjw@sisk.pl> <201209282355.31823.rjw@sisk.pl> <508F9588.5040105@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 30, 2012 04:53:28 PM Aaron Lu wrote:
> On 09/29/2012 05:55 AM, Rafael J. Wysocki wrote:
> > Define two device PM QoS flags, PM_QOS_FLAG_NO_POWER_OFF
> > and PM_QOS_FLAG_REMOTE_WAKEUP, and introduce routines
> > dev_pm_qos_expose_flags() and dev_pm_qos_hide_flags() allowing the
> > caller to expose those two flags to user space or to hide them
> > from it, respectively.
> > 
> > After the flags have been exposed, user space will see two
> > additional sysfs attributes, pm_qos_no_power_off and
> > pm_qos_remote_wakeup, under the device's /sys/devices/.../power/
> > directory.  Then, writing 1 to one of them will update the
> > PM QoS flags request owned by user space so that the corresponding
> > flag is requested to be set.  In turn, writing 0 to one of them
> > will cause the corresponding flag in the user space's request to
> > be cleared (however, the owners of the other PM QoS flags requests
> > for the same device may still request the flag to be set and it
> > may be effectively set even if user space doesn't request that).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  Documentation/ABI/testing/sysfs-devices-power |   31 ++++
> >  drivers/base/power/power.h                    |    6 
> >  drivers/base/power/qos.c                      |  169 ++++++++++++++++++++------
> >  drivers/base/power/sysfs.c                    |   95 +++++++++++++-
> >  include/linux/pm.h                            |    1 
> >  include/linux/pm_qos.h                        |   26 ++++
> >  6 files changed, 280 insertions(+), 48 deletions(-)
> > 
> > Index: linux/drivers/base/power/qos.c
> > ===================================================================
> > --- linux.orig/drivers/base/power/qos.c
> > +++ linux/drivers/base/power/qos.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/device.h>
> >  #include <linux/mutex.h>
> >  #include <linux/export.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include "power.h"
> >  
> > @@ -322,6 +323,38 @@ int dev_pm_qos_add_request(struct device
> >  EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
> >  
> >  /**
> > + * __dev_pm_qos_update_request - Modify an existing device PM QoS request.
> > + * @req : PM QoS request to modify.
> > + * @new_value: New value to request.
> > + */
> > +int __dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value)
> > +{
> > +	s32 curr_value;
> > +	int ret = 0;
> > +
> > +	if (!req->dev->power.qos) {
> > +		ret = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	switch(req->type) {
> > +	case DEV_PM_QOS_LATENCY:
> > +		curr_value = req->data.pnode.prio;
> > +		break;
> > +	case DEV_PM_QOS_FLAGS:
> > +		curr_value = req->data.flr.flags;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (curr_value != new_value)
> > +		ret = apply_constraint(req, PM_QOS_UPDATE_REQ, new_value);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> >   * dev_pm_qos_update_request - modifies an existing qos request
> >   * @req : handle to list element holding a dev_pm_qos request to use
> >   * @new_value: defines the qos request
> > @@ -336,11 +369,9 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_request
> >   * -EINVAL in case of wrong parameters, -ENODEV if the device has been
> >   * removed from the system
> >   */
> > -int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
> > -			      s32 new_value)
> > +int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value)
> >  {
> > -	s32 curr_value;
> > -	int ret = 0;
> > +	int ret;
> >  
> >  	if (!req) /*guard against callers passing in null */
> >  		return -EINVAL;
> > @@ -350,29 +381,9 @@ int dev_pm_qos_update_request(struct dev
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&dev_pm_qos_mtx);
> > -
> > -	if (!req->dev->power.qos) {
> > -		ret = -ENODEV;
> > -		goto out;
> > -	}
> > -
> > -	switch(req->type) {
> > -	case DEV_PM_QOS_LATENCY:
> > -		curr_value = req->data.pnode.prio;
> > -		break;
> > -	case DEV_PM_QOS_FLAGS:
> > -		curr_value = req->data.flr.flags;
> > -		break;
> > -	default:
> > -		ret = -EINVAL;
> > -		goto out;
> > -	}
> > -
> > -	if (curr_value != new_value)
> > -		ret = apply_constraint(req, PM_QOS_UPDATE_REQ, new_value);
> > -
> > - out:
> > +	__dev_pm_qos_update_request(req, new_value);
> 
> You forgot to assign the return value here.

Quite obviously.  I'm going to apply the appended patch for that.

Thanks for spotting it!

Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: PM / QoS: Fix the return value of dev_pm_qos_update_request()

Commit e39473d (PM / QoS: Make it possible to expose PM QoS device)
flags to user space introduced __dev_pm_qos_update_request() to be
called internally by dev_pm_qos_update_request(), but forgot to make
the latter actually use the return value of the former.  Fix this
mistake.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/qos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/base/power/qos.c
===================================================================
--- linux.orig/drivers/base/power/qos.c
+++ linux/drivers/base/power/qos.c
@@ -380,7 +380,7 @@ int dev_pm_qos_update_request(struct dev
 		return -EINVAL;
 
 	mutex_lock(&dev_pm_qos_mtx);
-	__dev_pm_qos_update_request(req, new_value);
+	ret = __dev_pm_qos_update_request(req, new_value);
 	mutex_unlock(&dev_pm_qos_mtx);
 
 	return ret;

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
