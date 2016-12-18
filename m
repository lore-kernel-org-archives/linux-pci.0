Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:60325 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753253AbcLRRU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Dec 2016 12:20:58 -0500
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
 <20161218075141.GE29850@kroah.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d7c26e15-34f3-26d4-e13a-f24b4a9034c3@deltatee.com>
Date: Sun, 18 Dec 2016 10:20:47 -0700
MIME-Version: 1.0
In-Reply-To: <20161218075141.GE29850@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: [RFC 1/1] MicroSemi Switchtec management interface driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

Thanks for the quick review!

On 18/12/16 12:51 AM, Greg Kroah-Hartman wrote:
> On Sat, Dec 17, 2016 at 10:09:22AM -0700, Logan Gunthorpe wrote:
>> +struct switchtec_dev {
>> +	struct pci_dev *pdev;
>> +	struct msix_entry *msix;
>> +	struct device *dev;
>> +	struct kref kref;
>
> Why do you have a pointer to a device, yet a kref as well?  Just have
> this structure embed a 'struct device' in itself, like you did for a
> kref, and you will be fine.  Otherwise you are dealing with two
> different sets of reference counting here, for no good reason.

Ok, understood. I had referenced the device dax driver which did it this 
way in 4.8 but looks like it was changed to the way you suggest in 4.9.

>> +#define stdev_pdev(stdev) ((stdev)->pdev)
>> +#define stdev_pdev_dev(stdev) (&stdev_pdev(stdev)->dev)
>> +#define stdev_name(stdev) pci_name(stdev_pdev(stdev))
>> +#define stdev_dev(stdev) ((stdev)->dev)
>
> Ick, just open code these please.  That's a huge hint your use of the
> driver model is not correct :)

Ok, will do. For reference, I was copying

drivers/ntb/hw/intel/ntb_hw_intel.h

which does a similar thing.

Logan
