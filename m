Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADC38F933;
	Thu, 26 Feb 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091772; cv=none; b=EWdFXwdM7aL7Nawdag54n6CZAU5YTY8j+zbRy8wKFjBySLPOPtIrOlgWsz4SZ/8XUZy/A7SVS+tvackRhLBVRyuNFD5cVqXqBfvbQ5kiaE+92W31/rT2AV1LZLsYNPaT92iB2ZrUYH/4WRWKuF4TbK8SCGCCEd1B31DgyYRf2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091772; c=relaxed/simple;
	bh=42JJgJXHDprNmz7eMBbUd9LtRDq0lfzNn/GUy/i9fOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGyhCCw8xplNcfa9x8fg1SfVyUv4y7lN9xN6wJYEMfIlMIU94gd4IeIJvo6s7CaxP1Ladt1Rbzitg5j1LfZdYMqs+EERgW5KFKIXl/7VY6gU86D1BQFdndyfZa9oaJE3Sy+iF+9RzbEkArPCB/x5b3V12kC6giVVqzbnxZHlX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd+UG/jP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd+UG/jP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC5C19422;
	Thu, 26 Feb 2026 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772091771;
	bh=42JJgJXHDprNmz7eMBbUd9LtRDq0lfzNn/GUy/i9fOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd+UG/jPypv+sizldrSxuZo1HmVigf3zTtE8Zl4rdpXXOt4KSSjKD715TF7upVzx8
	 Hsv6rvNN98IY/v4ovHt2i0t3HFIRyDqE5t48BjhBFk4uWnvQDVEj9oiZxjQPiVooxO
	 63ceccOgTOv8BVlbq1DAr7yKQFmKucllW+3wT2kr1iykthSaLlY+CJyWQP/DQYfZVG
	 qaEzgNJkwQng9ZsRxKocyg/aC0851Ne24B+P00xvcVXYICwc7nZT1Y/fdB18qxUsBD
	 T/BT4mFzhZtettLIprlhBtuJTRYH+egQjyDRLz+QZNGqf6/1Qvqu9YjacG+38xos8q
	 SRLfxMDQwMmwg==
Date: Thu, 26 Feb 2026 13:12:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank.Li@nxp.com, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Message-ID: <o35hfok2oegyxoajfhu3vwm2sstrykpuz3aytmrpy47popwhba@2ps7icbkx7e3>
References: <20251202072348.2752371-1-den@valinux.co.jp>
 <7hqhqbtqvrw6bqraykdbccllags6gyal6rekb6yehcfx2tzhet@lex46cqheta5>
 <ap43e4jypppkpavrhf4ewgeivwnfrlldykkqyf3oqk6i4ckbhx@cg47vhgjzbrc>
 <zet2ktcxydgsbf5ij4476vqqrb4apwfk2iag737ht5htphobhs@3dbc6i4vl26y>
 <eazctmg7ptxadg4oq34e2ydib2frm4x76f6jpzm763uswocufl@uwpz5zhkd7sr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eazctmg7ptxadg4oq34e2ydib2frm4x76f6jpzm763uswocufl@uwpz5zhkd7sr>

On Wed, Feb 18, 2026 at 10:09:13PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 19, 2026 at 01:36:16AM +0900, Koichiro Den wrote:
> > On Wed, Feb 18, 2026 at 09:52:08PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Feb 18, 2026 at 09:45:22PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Dec 02, 2025 at 04:23:41PM +0900, Koichiro Den wrote:
> > > > > The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
> > > > > through configfs (link/unlink functions, start/stop the controller, update
> > > > > parameters). In practice, several pitfalls present: double-unmapping when two
> > > > > windows share a BAR, wrong parameter order in .drop_link leading to wrong
> > > > > object lookups, duplicate EPC teardown that leads to oopses, a work item
> > > > > running after resources were torn down, and inability to re-link/restart
> > > > > fundamentally because ntb_dev was embedded and the vPCI bus teardown was
> > > > > incomplete.
> > > > > 
> > > > > This series addresses those issues and hardens resource management across NTB
> > > > > EPF and PCI EP core:
> > > > > 
> > > > > - Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
> > > > > - Fix configfs .drop_link parameter order so the correct groups are used during
> > > > >   unlink.
> > > > > - Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
> > > > >   avoiding crashes on .allow_link failures and during .drop_link.
> > > > > - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> > > > > - Manage ntb_dev as a devm-managed allocation and implement .remove() in the
> > > > >   vNTB PCI driver. Switch to pci_scan_root_bus().
> > > > > 
> > > > > With these changes, the controller can now be stopped, a function unlinked,
> > > > > configfs settings updated, and the controller re-linked and restarted
> > > > > without rebooting the endpoint, as long as the underlying pci_epc_ops
> > > > > .stop() is non-destructive and .start() restores normal operation.
> > > > > 
> > > > > Patches 1-5 carry Fixes tags and are candidates for stable.
> > > > > Patch 6 is a preparatory one for Patch 7.
> > > > > Patch 7 is a behavioral improvement that completes lifetime management for
> > > > > relink/restart scenarios.
> > > > > 
> > > > 
> > > > Are there any dependencies between pci-epf-vntb and ntb-epf drivers? If they are
> > > > not dependent, you should always post them separately.
> > 
> > I'll make sure to be more careful.
> > 
> > > > For this series, I can
> > > > merge the endpoint patches (except patch 4 which got merged in other form).
> > > > 
> > > 
> > > Sry, patch 2.
> > 
> > There are no dependencies between Patch 1 and Patch 3-7.
> > 
> > One minor note: I just realized that the Patch 5 subject is inconsistent.
> > 
> >   NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
> > 
> > should have been
> > 
> >   PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
> > 
> > If possible, could you please adjust the subject when applying?
> > 
> 
> Will do.
> 

This series fails to apply cleanly on top of pci/endpoint branch. Can you please
rebase and send the endpoint patches separately (with all changes)?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
