Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56267 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab2HTFCp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2012 01:02:45 -0400
From: "Taku Izumi" <izumi.taku@jp.fujitsu.com>
To: "'Yinghai Lu'" <yinghai@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>,
	"Kaneshige, Kenji/?? ??" <kaneshige.kenji@jp.fujitsu.com>,
	<jiang.liu@huawei.com>
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <CAE9FiQUZ+EHDGfAVU4wkYepT-97UVAkUNsKds4QVRJv=eNUTdQ@mail.gmail.com>
In-Reply-To: <CAE9FiQUZ+EHDGfAVU4wkYepT-97UVAkUNsKds4QVRJv=eNUTdQ@mail.gmail.com>
Subject: RE: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
Date: Mon, 20 Aug 2012 14:02:43 +0900
Message-ID: <075801cd7e91$08d4bd90$1a7e38b0$@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Yinghai Lu
> Sent: Saturday, August 11, 2012 1:41 AM
> To: Taku Izumi
> Cc: linux-pci@vger.kernel.org; bhelgaas@google.com; linux-acpi@vger.kernel.org; kaneshige.kenji@jp.fujitsu.com;
> jiang.liu@huawei.com
> Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
> 
> On Thu, Aug 9, 2012 at 11:09 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> >  Hi all,
> >
> >
> >  I'd like to merge hostbridge hotplug feature.
> >  I looked at Yinghai's branch and found that this branch contains
> >  many work and can be split into some parts.
> >  I believe it is good to merge step by step.
> >
> >  My idea is splitting into the following 4 parts:
> >    1. basic hostbirdge hotplug work
> >    2. acpiphp work
> >    3. /sysfs interface work (logical hotplug?)
> >    4. cleanup
> >
> >  This patchset is 1st step based on the following Yinghai's branch:
> 
> Hi,
> 
> Are you going to attend PCI mini-summit 8/28? We should discuss there.

  Sounds great. I'll attend PCI mini-summit.
 
  Best regards,
  Taku Izumi


> 
> Thanks
> 
> Yinghai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


