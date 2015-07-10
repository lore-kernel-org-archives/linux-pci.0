Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vn0-f42.google.com ([209.85.216.42]:40295 "EHLO
	mail-vn0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbbGJNWM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2015 09:22:12 -0400
MIME-Version: 1.0
In-Reply-To: <1435921425-15121-3-git-send-email-kishon@ti.com>
References: <1435921425-15121-1-git-send-email-kishon@ti.com>
	<1435921425-15121-3-git-send-email-kishon@ti.com>
Date: Fri, 10 Jul 2015 18:52:11 +0530
Message-ID: <CAHM4w1m5gfFbKF6Up8YNQA8rK+avXuz8HZgtbj6pQAndSa_zBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: host: pcie-designware: add support for suspend
 and resume
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, nsekhar@ti.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On Fri, Jul 3, 2015 at 4:33 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Certain platforms require MSE bit to be cleared to set the master
> in standby mode. (In DRA7xx TRM_vE, section 24.9.4.5.2.2.1 PCIe
> Controller Master Standby Behavior advises to use the clearing
> of the local MSE bit to set the master in standby. Without this
> some of the clocks do not idle).
>
> Cleared the MSE bit on suspend and enabled it back on resume.
> This is required to get suspend/resume working.

Have you tested with a card having IO space memory as well.
I think you might need to require clear and enable PCI_COMMAND_IO
in suspend and resume respectively.

~Pratyush
