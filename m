Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF1AC43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89392084F
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfDZMOY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:14:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:47835 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfDZMOY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Apr 2019 08:14:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 05:14:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="294756163"
Received: from mylly.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga004.jf.intel.com with ESMTP; 26 Apr 2019 05:14:20 -0700
Subject: Re: [Bug 203297] Synaptics touchpad TM-3127 functionality broken by
 PCI runtime power management patch on 4.20.2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keijo Vaara <ferdasyn@rocketmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20190422130814.GJ173520@google.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <3a1139ef-10ed-6923-73c5-30fbf0c065c3@linux.intel.com>
Date:   Fri, 26 Apr 2019 15:12:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422130814.GJ173520@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/22/19 4:08 PM, Bjorn Helgaas wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=203297
> 
> Regression, suspected but as yet unconfirmed cause:
> 
>    c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")
> 
> backported to 4.20 stable as 39e1be324c2f.
> 
With help of Keijo it was confirmed above patch broke the Synaptics 
touchpad. Not bisected but touchpad works again by forcing the i2c-i801 
SMBus controller always on:
"echo on >/sys/bus/pci/devices/0000\:00\:1f.3/power/control"

Above patch is a generalized fix that fixed the runtime PM regression on 
i2c-i801 and re-allow the controller go to runtime suspend when idle. So 
most probably Synaptics touchpad was broken by i2c-i801 runtime PM also 
before but got unnoticed. Which is easy since on many platforms SMBus 
controller doesn't necessarily have the PCI PM capabilities.

I would like to ask help from input subsystem experts what kind of SMBus 
power state dependency Synaptics RMI4 SMBus devices have since it cease 
to work if SMBus controllers idles between transfers and how this is 
best to fix?

Instead of revert I think we'd need to have some method to force SMBus 
controller on whenever the touchpad is active, like when there is a 
userspace listening.

I'm not expert in this area so as quick proof of concept I had a 
following hack which forces the I2C/SMBus adapter, and eventually the 
parent PCI device of it on when the RMI4 SMBus device is probed and let 
the SMBus controller to idle when removed.

According to Keijo it fixes the issue but I like to hear input experts 
for better place to put these.

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index b6ccf39c6a7b..2b11d69be313 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -16,6 +16,7 @@
  #include <linux/lockdep.h>
  #include <linux/module.h>
  #include <linux/pm.h>
+#include <linux/pm_runtime.h>
  #include <linux/rmi.h>
  #include <linux/slab.h>
  #include "rmi_driver.h"
@@ -332,6 +333,9 @@ static int rmi_smb_probe(struct i2c_client *client,

  	dev_info(&client->dev, "registering SMbus-connected sensor\n");

+	/* Force SMBus adapter on while RMI4 device is connected */
+	pm_runtime_get(&client->adapter->dev);
+
  	error = rmi_register_transport_device(&rmi_smb->xport);
  	if (error) {
  		dev_err(&client->dev, "failed to register sensor: %d\n", error);
@@ -346,6 +350,7 @@ static int rmi_smb_remove(struct i2c_client *client)
  	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);

  	rmi_unregister_transport_device(&rmi_smb->xport);
+	pm_runtime_put(&client->adapter->dev);

  	return 0;
  }

-- 
Jarkko
