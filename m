Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A34B3CE4B5;
	Fri,  4 Sep 2026 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542008; cv=none; b=p+86lrwYi7E/DnScrJ6J1PBB8zgpo7OJpqVzF9gwO+WAKlkBJ4a68HeMYCttAC4DnSSX7XGZelv7xdIgms+bn7Lp8VMwKWxwhXdUF51gvLNEp63xvGHc6cf+ojElI25x//+GFsM92G9ouvXwylj32bynpvL5U6eSg4ZXZHzCerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542008; c=relaxed/simple;
	bh=b2101sSBCvgnvWQACpINASspILyGwVzxxNj4fInNtNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P5U1JH70rmewvRG6fu3RpkAI/lRqNkFyMiuVwrLe7GE27bYBZJfSxQizpCtwiVWQODjH4tsHMS/9vikLlYdpRz7INfXsmTy+2c1p2DZZWgZgrw925ReruCJdcYaD/GfbnmVFvA1fweIWt1NsfHRr7zbyGqZEq8l6BNdjWLiLTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P55kHxkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P55kHxkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96191F00A3D;
	Fri,  4 Sep 2026 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542007;
	bh=zghVW8LrzfVAXicbid/ZnghEAcu2zWXdU339+k66b+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=P55kHxkxEKy2WXTQdprwJZ3x6jlyoYkrwWC4PtP6FvckCVpfyihRkEalHJHiPjxnf
	 3TBFHXFant6NZ4B3P2EdAMqvBvDTuRuZzI2aAYtzemhQMsskwtcOHkB0b/Dq7f8M64
	 Iho/rQjtBrJmJVLWvB/qj8+ecCToO7aWyOjqZgj+dM0l2pF7gmsD/+rkHyyddudp1x
	 cPYw62EVO5H8A+vtl2VKPn6PIKFP+P1JnEfzDSkHcxlATmSUYeFb9zCoEBjVeXfo8Z
	 w1LHxSa/RuNtUR0B5U8GmX0v3exanQe7xB3003gSO0BqsQ2G4wtQDEXA//cun/txV4
	 BzCmUdnIW9GRw==
Date: Fri, 4 Sep 2026 12:13:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	a-garg7@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Feizhou Yu <yufeizhou201@163.com>
Subject: Re: [PATCH] pci: dwc: Rename PCIE_PORT_LINK_CONTROL to
 PORT_LINK_CTRL_OFF
Message-ID: <20260904171325.GA2326692@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb29846-7561-4ead-9a05-0c5966de5fd6@163.com>

On Sat, Sep 05, 2026 at 12:32:30AM +0800, Hans Zhang wrote:
> On 9/5/26 00:12, Bjorn Helgaas wrote:
> > On Fri, Sep 04, 2026 at 02:18:23PM +0800, Hans Zhang wrote:
> > > The register at offset 0x710 is documented in the Synopsys DesignWare
> > > PCIe Controller Reference Manual as "PORT_LINK_CTRL_OFF" (Port Link
> > > Control Register). The current macro name PCIE_PORT_LINK_CONTROL does
> > > not match the documentation, making it difficult to cross-reference
> > > with the spec when debugging or maintaining the code.
> ...

> I agree with what you said. The official documentation of Synopsys currently
> defines it this way. If the naming is simplified, it would make it harder to
> search for where the registers are located. This is one of the purposes of
> this modification.

One possibility is to add a one-line comment at the #define containing
the name used in the spec.  It's not perfect, but that's basically
what's in pci_regs.h:

  #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
  #define PCI_EXP_LNKCTL          0x10    /* Link Control */
  #define PCI_EXP_LNKSTA          0x12    /* Link Status */
