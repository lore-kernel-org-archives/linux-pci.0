Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37196 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848Ab2HVRb0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Aug 2012 13:31:26 -0400
Received: by vbbff1 with SMTP id ff1so1298700vbb.19
        for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 10:31:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120822101533.GA2332@ram-ThinkPad-T61>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
	<CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
	<CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
	<20120816032602.GN2449@ram-ThinkPad-T61>
	<CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
	<20120816044104.GQ2449@ram-ThinkPad-T61>
	<20120821151245.GA2356@ram-ThinkPad-T61>
	<CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
	<20120822101533.GA2332@ram-ThinkPad-T61>
Date: Wed, 22 Aug 2012 10:31:25 -0700
Message-ID: <CAE9FiQVDkzFkjrBrZC9JpLW7JoquE_f-5BKGrbmmZMHFVcw=cw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 ]pci: pci resource iterator
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 22, 2012 at 3:15 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> On Tue, Aug 21, 2012 at 04:22:52PM -0700, Yinghai Lu wrote:
>> On Tue, Aug 21, 2012 at 8:13 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> by exposing idx through the interface, we are exposing the implementation to
> the enduser. I want the end user not know that the resources are
> structured as a array. This will help easily restructure resources
> in the pci_dev structure to whatever implementation we want, linked list
> or hash or whatever...
>
> Why can't the addon resource be hidden behind the interface? something
> like this?

keep the idx would make thing simple for referencing and converting.

pci_dev_resource_n() would be wrapper to from idx to real resource pointer.
we just need to change &dev->resource[i] referencing to
pci_dev_resource_n(dev, i) instead.

We did that before for irq_desc storage converting, and now we have
     for_each_irq_desc(irq, desc)

later for the resource allocation, I will change resource member from
          struct resource resource[DEVICE_COUNT_RESOURCE];
to
          struct resource *std_res;
