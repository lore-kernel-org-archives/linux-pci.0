Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:39614 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751271AbaCTQt2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Mar 2014 12:49:28 -0400
Message-ID: <532B1C14.6050902@codethink.co.uk>
Date: Thu, 20 Mar 2014 17:49:24 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Phil.Edworthy@renesas.com
CC: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH 1/9 v3] PCI: host: rcar: Add Renesas R-Car PCIe driver
References: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com> <1394704208-7490-2-git-send-email-phil.edworthy@renesas.com> <OFA03366C1.FF33E94A-ON80257CA1.005B32AE-80257CA1.005BAE71@eu.necel.com>
In-Reply-To: <OFA03366C1.FF33E94A-ON80257CA1.005B32AE-80257CA1.005BAE71@eu.necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/03/14 17:41, Phil.Edworthy@renesas.com wrote:
> Hi,
>
> Whilst looking at something else, I've realised that I completely messed
> up my use of runtime PM in this driver... I'll fix that up & resend.

Yes, you don't need the suspend/resume hooks at-all by the looks
of it. Hopefully the pm_runtime driver for shmobile will be sorted
upstream soon.

And it looks as if your hooks would never have been called anyway
as your probe does a pm_runtime_get_sync() to keep the pm_runtime
for the device open (which probably for this bus bridge is what
you wanted)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
