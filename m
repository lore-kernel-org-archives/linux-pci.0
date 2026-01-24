Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51826A0A7;
	Sat, 24 Jan 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769286332; cv=none; b=Vi73L7dBxdRR1nwrHFI7iglTzftdBSgJE39KOc/zhrStLFwJ9sxZzC8c8Agj+g983NI+ULafqOnJZsHO4VTd+OQ4xoSTJrpLU/J/rPAgDyM3xOjFn0Ry0ZEpz3d390HIBfMVbAAYWEHzTEiy7qbZHFHhM2fGw6wG59DcncQu1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769286332; c=relaxed/simple;
	bh=L+QhuojfaBA9QSIcpB55TXjhoDCmYj7pNFBEvUVUBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EkALzWVi1KvjUt+TmrJVaWmjjuzQqsdt0Yd698kpgzPOFETtlU+Hjg0xiFGSXroFm25TSbtYK2wLv9sCD+nZrCdd7Zg/82iYo4j7W4qd05hdJwJpCOMv/sfscQgjZCW4FCo3zFgtsKtggeDdSMVwRMXxPX13tETciX8CLrTTxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZaKZ9sv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZaKZ9sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DCCC116D0;
	Sat, 24 Jan 2026 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769286332;
	bh=L+QhuojfaBA9QSIcpB55TXjhoDCmYj7pNFBEvUVUBKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KZaKZ9svZp8hG1PD93Qe6VS8J3aNL/Sz3zvRtuZbszPWlYShlTqEYtD7PknAKgyA7
	 zNZXZiwCJs9iNtFc7BqN/x+K34oUI2Eg61yTj7/mhQSgpYb/andZyNcWjsnjXc8KnV
	 gTLZj63CDbaSLRmvnL7XwQbQMXqXoTyJYyr9sNjE2H628J0ioofnEYyZL1u5uROckX
	 TC2HyUs87ic/6V9HRywAEk+0SFqRgfWAzC4zMsEmPhlY0eD97tLTntc/N4KUO2e/4P
	 JlZVncCii5Esdl/AR8JrHs/04M7cEosyLhm+OcurWROkCI8gELbzh6bQt/TUovkVf6
	 sbs4eXibyQDaQ==
Date: Sat, 24 Jan 2026 14:25:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lkp@intel.com" <lkp@intel.com>,
	"error27@gmail.com" <error27@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error
 message
Message-ID: <20260124202530.GA175580@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA4PR12MB9810A988D4192F92AB760CECCD95A@IA4PR12MB9810.namprd12.prod.outlook.com>

On Sat, Jan 24, 2026 at 02:02:51PM +0000, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Rakuram,
> 
> > -----Original Message-----
> > From: Rakuram Eswaran <rakuram.e96@gmail.com>
> > Sent: Wednesday, December 24, 2025 12:10 AM
> > To: lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > robh@kernel.org; bhelgaas@google.com
> > Cc: lkp@intel.com; error27@gmail.com; Musham, Sai Krishna
> > <sai.krishna.musham@amd.com>; tglx@linutronix.de; jirislaby@kernel.org;
> > Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
> > pci@vger.kernel.org; linux-kernel@vger.kernel.org; Rakuram Eswaran
> > <rakuram.e96@gmail.com>; Dan Carpenter <dan.carpenter@linaro.org>
> > Subject: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error message
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > The INTx devm_request_irq() failure path logs an incorrect IRQ
> > number. The printed 'irq' variable refers to a previous MDB
> > interrupt mapping and does not correspond to the INTx IRQ being
> > requested.
> >
> > Fix the error message to report pcie->intx_irq, which is the IRQ
> > associated with the failing request.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202512230112.AaiGqMWM-lkp@intel.com/
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> > ---
> > Testing note:
> > Compile-tested only.
> >
> > Static analysis was performed with Smatch to ensure the reported warning
> > no longer reproduces after applying this fix.
> >
> > Command using for testing:
> > ~/project/smatch/smatch_scripts/kchecker ./drivers/pci/controller/dwc/pcie-amd-
> > mdb.c
> >
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-
> > amd-mdb.c
> > index 3c6e837465bb..7e50e11fbffd 100644
> > --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > @@ -389,7 +389,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
> >                                IRQF_NO_THREAD, NULL, pcie);
> >         if (err) {
> >                 dev_err(dev, "Failed to request INTx IRQ %d, err=%d\n",
> > -                       irq, err);
> > +                       pcie->intx_irq, err);
> 
> The fix is correct. The `irq` variable at that point contains the last
> IRQ mapped in the preceding for loop (an MDB event IRQ), not the INTx
> IRQ being requested via devm_request_irq(). Using `pcie->intx_irq`
> accurately reports the failing IRQ number.
> 
> Thanks,
> Sai Krishna

Sai, if you include a "Reviewed-by: Sai Krishna <email-addr>", we can
add that when merging the fix.  It sounds like that's your intent, but
I don't want to presume.
