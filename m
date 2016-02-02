Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35666 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933093AbcBBP6X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 10:58:23 -0500
Date: Tue, 2 Feb 2016 09:58:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Emulate pci deviceID/vendor for driver debug ?
Message-ID: <20160202155819.GA25306@localhost>
References: <CAJ2oMhKMcwX+5SUR6_jANqVu-F9nbmx5+k8G+wym6BvVuH3uoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ2oMhKMcwX+5SUR6_jANqVu-F9nbmx5+k8G+wym6BvVuH3uoQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ran,

On Tue, Feb 02, 2016 at 01:39:29PM +0200, Ran Shalit wrote:
> Hello,
> 
> Is there some simple way - just for debug purpose - to make the kernel
> think that the driver matches the board/vendor , so that the driver
> will be called ?
> I don't have the real harware yet (even not a pci physical interface
> for any card), but wanted to start debugging some template driver.

If you haven't seen it already, Linux Device Drivers should answer
many of your questions, and it's freely available online:
https://lwn.net/Kernel/LDD3/

If you write a template driver, you can put whatever vendor/device IDs
you want in the pci_device_id table, and then the driver will match
the device you care about.  You might have to disable the driver (or
unload the driver module) that normally claims the device.

Bjorn
