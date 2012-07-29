Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36736 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2G2Mga (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2012 08:36:30 -0400
MIME-Version: 1.0
In-Reply-To: <20120726170925.GA24751@kroah.com>
References: <CAHzK-V0XpkVJHgqWiWpYP1jx5DPX=voE0eymK+5FG-zhrJOwAQ@mail.gmail.com>
 <20120726170925.GA24751@kroah.com>
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Sun, 29 Jul 2012 15:36:09 +0300
Message-ID: <CAHzK-V0idPrHhf-YuC_HAxxxQABExW7mUUWN31f-ZpdnC8W+GA@mail.gmail.com>
Subject: Re: Cabled PCIE device hotplug/hot-removal
To: Greg KH <greg@kroah.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2012 at 8:09 PM, Greg KH <greg@kroah.com> wrote:
> On Thu, Jul 26, 2012 at 08:03:09PM +0300, Shlomo Pongratz wrote:
>> Hi,
>>
>> I have a  PCIe device connected with cables to a host (kernel 3.5.0-rc7+).
>> What are the handler I need to add to a driver in order to catch cable
>> pull-out / push-in?
>
> You shouldn't need anything special, aren't you already getting probe
> and disconnect callbacks when the device is discovered and removed?

When the device is loaded the probe is called
When I "echo 1" to the remove sysfs entry the remove callback is called.
But when I power down the card no callback is called.
>
>> The pcisig presentation
>> "http://www.pcisig.com/developers/main/training_materials/get_document?doc_id=f4ca40ec1721aa7fadd05e2903b0172c36656294"
>> talks about PERST# detection for cabled PCIe hotplug.
>>
>> Does the kernel detect it?
>>
>> None of the pci_driver or pci_error_handlers callbacks were called
>> when using powered down/up the device (electrically).
>
> Do you have the pciehp driver loaded properly when this happens?

My {dot}config includes it into the kernel, i.e.
CONFIG_HOTPLUG_PCI_PCIE=y

>
> thanks,
>
> greg k-h

Thanks,
