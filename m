Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40080 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbaBUSbc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 13:31:32 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so1458530oag.30
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2014 10:31:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140219005241.GE8786@google.com>
References: <20140217045004.GB3230@yanx>
	<CAE9FiQXmWG2RNP-t=U06JUsqkmDm2My5762za8QuwUMZsG+yNg@mail.gmail.com>
	<CAE9FiQWxcBCy+dp-0D2erB83uyyTNKFo5y0sKwiiFxo1xM0Z=g@mail.gmail.com>
	<20140219005241.GE8786@google.com>
Date: Fri, 21 Feb 2014 10:31:32 -0800
Message-ID: <CAE9FiQUVP96YAwn8MCNZs0njvThzARHucE8ukhQ0oM7jTi+OZQ@mail.gmail.com>
Subject: Re: Support huge alignment in pbus_size_mem()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Nikhil P Rao <nikhil.rao@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 4:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Why did you add the loop above?  Didn't the original loop compute the same
> value of mem64_mask as your new loop?

it is the same at last. but that could be different in the middle.
like several resources, but only last one can not use 64bit resource.

Thanks

Yinghai
