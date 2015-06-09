Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Jun 2015 11:16:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 01/18] NTB: Move files in preparation for NTB
 abstraction
Message-ID: <20150609161637.GB23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <8b1fb23f83098cf14b39a898a638394e52e91473.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8b1fb23f83098cf14b39a898a638394e52e91473.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 05:44:28AM -0400, Allen Hubbe wrote:
> This patch only serves the purpose to move files to their new locations,

s/only serves the purpose to move/moves/

> before applying the next patch adding the NTB Abstraction layer.
> Splitting this patch from the next is intended make distinct the which

s/the which/which/

> code is changed only due to moving the files, versus which are
> substantial code changes in adding the NTB Abstraction layer.
