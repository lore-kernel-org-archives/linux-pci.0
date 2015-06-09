Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Jun 2015 11:43:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 13/18] NTB: Use NUMA memory and DMA chan in transport
Message-ID: <20150609164343.GF23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <405348e755bb4f78b6229f0d1ff2a347f0497505.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <405348e755bb4f78b6229f0d1ff2a347f0497505.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 05:44:40AM -0400, Allen Hubbe wrote:
> Allocate memory and request the dma channel for the same numa node as
> the ntb device.

It'd be nice if DMA, NUMA, and NTB were capitalized in the changelog the
same way as in the subject line.
