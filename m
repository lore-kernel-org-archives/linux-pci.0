Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FAE28690;
	Wed,  4 Mar 2026 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606045; cv=none; b=dwwpgN3L2DXDFDlFcGGTxLMH5ljqutTPygHTyUXb+MJAJFXn/ONgJJvPEPgsimb55/yUoswmDl0YTE/tfScIl+9/VuvgNaUBaKyB75UOoHkkIU0Nx5x26hcr+sCFD+mZgVP5ecYp/gcqT4i6R1NzyBxL9vmKG+lb/7QaMvIOdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606045; c=relaxed/simple;
	bh=oVIEPDU/nugqJeCpaCeerhYE0aOaD71Oxv3iXD8UH6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up6sjcj58GnIm11qEsblEUYOZcWBFQBFkf0liLjwFfh217ya8Ee6xzmuD0TJzPJP8QcMXKIq8+Vc1oheeiJXwOPc0k+cl0NbURng6SuPohzzA7pATX8MnqYYOHOOdjpoHhOFGyAZrt4AsgZSPuaSjxUsvu2L2X3uvxl/INahQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BauUP7sl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BauUP7sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244D6C19423;
	Wed,  4 Mar 2026 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772606044;
	bh=oVIEPDU/nugqJeCpaCeerhYE0aOaD71Oxv3iXD8UH6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BauUP7slxOLlEYowI0YIqmZjRKU+TN7e7GoDub7PxEBkwHm9B4txYf9VpEHvZkGsP
	 /jOKWCidq1MH+kGRd7A/kVNKIoL1HkH0ChFECnciWfi+U7JTD3N+k47/A2P12q3sW8
	 RKgHNhT55bZ6PNPepUvznjbYExp0aPXYANv62V8C9usNWrka1LkguU6cZYbWn13ubj
	 yxAIIL/lT6lT8EU+5eBpIV/GNo6V/c2n8f7olFOwwSMnGJRBraR7BaFv/TYe1z1Olz
	 INFnnDVcYfRIg8n0MHgSvU0ir6MgJaxp7/bwyY1U4BJaJRZ8l0XrAtCA/gdehWsG8x
	 qDpldJFdP5qjg==
Date: Wed, 4 Mar 2026 12:03:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, kwilczynski@kernel.org, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Ye Bin <yebin10@huawei.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] PCI: endpoint: pci-epf-*ntb: Harden vNTB resource
 management
Message-ID: <owgu3bsmcvyy5ggygak6iof3v26fho2sa2wcpmh3ksxjzgq3bc@osi4xob6fpry>
References: <20260226084142.2226875-1-den@valinux.co.jp>
 <urqlfeqcp4grwqia5tu5am2qmzvbkiqubyxtl4pijlceidlelz@jm3lrlpcg3rp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <urqlfeqcp4grwqia5tu5am2qmzvbkiqubyxtl4pijlceidlelz@jm3lrlpcg3rp>

On Wed, Mar 04, 2026 at 12:10:23PM +0900, Koichiro Den wrote:
> On Thu, Feb 26, 2026 at 05:41:37PM +0900, Koichiro Den wrote:
> > The vNTB endpoint function (pci-epf-vntb) can be configured and
> > reconfigured through configfs (link/unlink functions, start/stop the
> > controller, update parameters). In practice, several pitfalls present:
> > duplicate EPC teardown that leads to oopses, a work item running after
> > resources were torn down, and inability to re-link/restart fundamentally
> > because ntb_dev was embedded and the vPCI bus teardown was incomplete.
> > 
> > This series addresses those issues and hardens resource management of
> > pci-epf-vntb:
> > 
> > - Remove duplicate EPC resource teardown in both pci-epf-vntb and
> >   pci-epf-ntb, avoiding crashes on .allow_link failures and during
> >   .drop_link.
> > - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> > - Manage ntb_dev as a devm-managed allocation and implement .remove() in
> >   the vNTB PCI driver. Switch to pci_scan_root_bus().
> > 
> > With these changes, the controller can now be stopped, a function
> > unlinked, configfs settings updated, and the controller re-linked and
> > restarted without rebooting the endpoint, as long as the underlying
> > pci_epc_ops .stop() is non-destructive and .start() restores normal
> > operation.
> > 
> > Patches 1-3 carry Fixes tags and are candidates for stable.
> > Patch 4 is a preparatory one for Patch 5.
> > Patch 5 is a behavioral improvement that completes lifetime management for
> > relink/restart scenarios.
> 
> While I'm updating Patch 4 and 5 to address feedback from Mani, as well as the
> concern I mentioned at [1], I noticed that if [2] gets merged before this
> series, another issue may arrise. With [2], the DB IRQ may become a shared IRQ,
> in which case the unbind/remove race would require additional care.
> 
> 
> Mani, if it's ok, could you take Patch 1-3?
> 
> - If so, I'll spin the rest (Patch 4-5) into a separate patch series starting
>   from v6, with some additional commits.
> 

Sounds OK to me.

- Mani

>   It turns out that Patch 4-5 are a bigger change than I initially thought. Even
>   though Patch 1-3 were originally written as preparatory fixes, they can be
>   applied independently at any time.
> 
>   The code in Patches 1-3 has also been unchanged since v1 (submitted last
>   October).
> 
> [1] https://lore.kernel.org/linux-pci/mipdls67csyyrugf4rjx3qqtbxes4sjjtluy3psecnadcgcs7k@rn42d3m6ggsf/
> [2] [PATCH v10 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
>     https://lore.kernel.org/linux-pci/20260302071427.534158-1-den@valinux.co.jp/
> 
> 
> Best regards,
> Koichiro
> 
> > 
> > ---
> > v4->v5 changes:
> >   - Rebased onto the latest pci/endpoint (2026-02-26).
> >   - Dropped [PATCH v4 1/7]; will be reposted separately via the NTB tree.
> >   - Dropped [PATCH v4 2/7], which has been applied in a different form.
> >   - Corrected the subject prefix of [PATCH v4 5/7]:
> >     s/NTB: epf: vntb:/PCI: endpoint: pci-epf-vntb:/.
> >   - Picked up a Reviewed-by tag to [PATCH v4 7/7].
> >   - Resolved a conflict in [PATCH v4 7/7] due to commit
> >     dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support").
> > v3->v4 changes:
> >   - Added Reviewed-by tag for [PATCH v3 6/6].
> >   - Corrected patch split by moving the blank-line cleanup,
> >     based on the feedback from Frank.
> >   (No code changes overall.)
> > v2->v3 changes:
> >   - Added Reviewed-by tag for [PATCH v2 4/6].
> >   - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
> >   (No code changes overall.)
> > v1->v2 changes:
> >   - Incorporated feedback from Frank.
> >   - Added Reviewed-by tags (except for patches #4 and #6).
> >   - Fixed a typo in patch #5 title.
> >   (No code changes overall.)
> > 
> > v4: https://lore.kernel.org/linux-pci/20251202072348.2752371-1-den@valinux.co.jp/
> > v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
> > v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
> > v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/
> > 
> > 
> > Koichiro Den (5):
> >   PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
> >   PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
> >   PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in
> >     epf_ntb_epc_cleanup
> >   PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
> >     pci_scan_root_bus()
> >   PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
> >     teardown
> > 
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 88 ++++++++++++-------
> >  2 files changed, 57 insertions(+), 87 deletions(-)
> > 
> > -- 
> > 2.51.0
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
