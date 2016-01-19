Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34590 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbcASXuh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 18:50:37 -0500
Received: by mail-wm0-f48.google.com with SMTP id u188so164143207wmu.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Jan 2016 15:50:36 -0800 (PST)
Subject: Re: ID conflict between bdc_pci and "720p FaceTime HD Camera"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <569BB4C2.3020602@gmail.com> <20160119225806.GA1841@localhost>
Cc: linux-pci@vger.kernel.org,
	Ashwini Pahuja <ashwini.linux@gmail.com>,
	Felipe Balbi <balbi@ti.com>
From: Xavier Gnata <xavier.gnata@gmail.com>
Message-ID: <569ECBC9.9090800@gmail.com>
Date: Wed, 20 Jan 2016 00:50:33 +0100
MIME-Version: 1.0
In-Reply-To: <20160119225806.GA1841@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 19/01/2016 23:58, Bjorn Helgaas wrote:
> [+cc Ashwini, Felipe]
>
> On Sun, Jan 17, 2016 at 04:35:30PM +0100, Xavier Gnata wrote:
>> Hello,
>>
>> The development of a driver for
>> 02:00.0 Multimedia controller [0480]: Broadcom Corporation 720p
>> FaceTime HD Camera [14e4:1570]
>> has started. It is still in an early stage but it's progressing and
>> it already streams.
>> https://github.com/patjak/bcwc_pcie
>>
>> However, as you can see, this webcam shares the exact same ID as
>> bdc_pci 0x1570 .
>>
>> Could we use e.g. PCI_CLASS in bdc_pci to avoid grabbing the webcam
>> incorrectly?
>> The FaceTime HD Camera has PCI_CLASS 0x048000
>> I hope that bdc_pci has another PCI_CLASS.
>> Or maybe there is a better way to distinguish bdc_pci from FaceTime
>> HD Camera. What do you think?
>
> This is what the PCI Vendor/Device IDs are for.  It's a shame that
> Broadcom apparently screwed up and used the same IDs in two different
> devices.
>
> At least, I *assume* they're different.  I can't really tell what the
> bdc_pci driver does, so it's conceivable that it's using the same
> device in a different way than you are.
>
> If they really are different devices, using the class code sounds like
> a reasonable way to differentiate them.
>
> Bjorn
>

bdc is "Broadcom's USB3.0 device controller IP" in the SOC world which 
is connected through PCIe on FPGA-PCIe based platform.
Nothing to do with the Facetime HD webcam of a macbook air.
Broadcom screwed up.

The issue is that I don't have access to such a BDC.
I also don't find it in
http://pcidatabase.com/vendor_details.php?id=767
which lists 0x1570 as being the webcam.

Where can we find the PCI class of this "Broadcom's USB3.0 device 
controller IP" ? Ashwini?

Xavier
