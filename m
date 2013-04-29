Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:48859 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab3D2LMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Apr 2013 07:12:12 -0400
Message-ID: <517E45C8.4060407@cn.fujitsu.com>
Date: Mon, 29 Apr 2013 18:04:56 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix racing for pci device removing via sysfs
References: <1366940841-15370-1-git-send-email-yinghai@kernel.org> <CAErSpo5zfHR-agNBdgqfVjCU+-KcTZV+1bvML5Uw-+icDqzzEA@mail.gmail.com> <CAE9FiQVEQO-dLJRjn9Z7JgwGWAn1M8S1Tn2_V0Fq+6kB0rG=Bg@mail.gmail.com> <CAErSpo7DUDQ_XgVKAfWxqYJA=q85ps46bffV-4a7b0vOzAP5DA@mail.gmail.com> <CAE9FiQWv-bN2XzHiQ0WU+Y678zcqs_Owua6vXXijdMO6=0OWpg@mail.gmail.com>
In-Reply-To: <CAE9FiQWv-bN2XzHiQ0WU+Y678zcqs_Owua6vXXijdMO6=0OWpg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,

On 04/27/2013 05:01 AM, Yinghai Lu wrote:

> On Fri, Apr 26, 2013 at 1:53 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
>>
>> You can't be serious.  This is a disgusting mess.  Checking a list
>> pointer for LIST_POISON1?  As far as I'm concerned, this is a waste of
>> my time.
> 
> Well, then need to hold the bus ref, and check bus->devices list instead.

@@ -341,6 +352,7 @@ remove_store(struct device *dev, struct
 {
 	int err;
 	unsigned long val;
+	struct pci_dev *pdev;
 
 	if (strict_strtoul(buf, 0, &val) < 0)
 		return -EINVAL;
@@ -351,9 +363,14 @@ remove_store(struct device *dev, struct
 	/* An attribute cannot be unregistered by one of its own methods,
 	 * so we have to use this roundabout approach.
 	 */
+	pdev = pci_dev_get(to_pci_dev(dev));

There is no need to increase pci_dev's ref here, because we'll increase it 
in sysfs_schedule_callback.

+	get_device(&pdev->bus->dev);

So the pci_bus' ref management is still needed.
 
 	err = device_schedule_callback(dev, remove_callback);
-	if (err)
+	if (err) {
+		put_device(&pdev->bus->dev);
+		pci_dev_put(pdev);
 		return err;
+	}
 
 	return count;
 }

