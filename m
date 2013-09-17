Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33592 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753008Ab3IQRmZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 13:42:25 -0400
Date: Tue, 17 Sep 2013 19:42:20 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH V2 3/3] PCI: mvebu: add missing __iomem annotation
Message-ID: <20130917194220.47406b49@skate>
In-Reply-To: <001c01ceb366$9bad8740$d30895c0$%han@samsung.com>
References: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
	<001c01ceb366$9bad8740$d30895c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

On Tue, 17 Sep 2013 14:27:31 +0900, Jingoo Han wrote:
> Added missing __iomem annotation in order to fix the following
> sparse warning:

I believe your commit title and log is now wrong: this commit is not
adding an iomem annotation anywhere.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
