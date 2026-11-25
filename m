Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565320;
	b=DR5KZWp7kcS3wV3i8YNHeXntjmQpVlp/TZhKgWZfQD8mhqm9s9XzaLI+K3nNUvLL5j8K
	 J+VsgZN/sGGGPX6kIoFZJrm0ArL0PJiPmkUsJZPCFtjHAJrWxPvz6zdylDfuHaroexZlA
	 20NgVtyngksj0+GwiXNVemkpobt3b0HFLN78JLYxvQuzTjsAHYsDAnL5TJ747GLQwnYMj
	 yoxgEP/S/u7BX9nYESeWPKbx4YNxux3qUHO9dGS/bcOIgBT1CLduRNCu/rmKaU8z9wHPZ
	 p+h8xK6DXbaPRM8t9jae3Fm5Qj0jh2y79/jFU81WYK3cv6fm+64XxaKFgSyaofIMw3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565320;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Mb1VUJyQXUJd5r0N+87LOv0VhAv9PGlLG895h5R0p/w=;
	b=VGGO5NV6tZMIPLcIkz/kfX0PkfkwrfQsOqwhMebN8ZxXRjIZqc4G/Gnfm4OreottL7iZ
	 zuxxFoyEcJL4VIS2NJG1keAVK4cHy5hynC+2+V65PWKPzLAMgNaoWd7FQQHRjGoTsrwq6
	 KhxNaqpiePnNPy/ECudYBhd9DG6kqz3gkZFh+R4oNEVrmvCEmE2KvrxT1lTb3FNqXY/h1
	 aJquzEhtHbhZqAIuGn4pZhotGbwpc7ONJ5v2WkfaP4IhOzDim+Ckp82rehBCHJiDLxU7p
	 zxq4U+otHqJYMGV3XdfFu+4stiTuzdBECnZsRyAigxb5aCaZ7aOdlAU1umwxwCJJNVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKkkkSdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99A606A331;
	Wed, 25 Nov 2026 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKkkkSdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897C51F000C6;
	Wed, 25 Nov 2026 00:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795565319;
	bh=Mb1VUJyQXUJd5r0N+87LOv0VhAv9PGlLG895h5R0p/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dKkkkSdi2xQQIlhXTiQUdp3dDtWoJu1Qz/G7bqC3Ll9mAH1G4W9gtMnznmDLOOLxD
	 55LGHk5xoKzT+1EJVFHjm3jVIUN4kJhZfpmdq0RcJNXYbsZ8xTWkOPFPbGLaChWd0u
	 c8jlw3eZ3Q9kRPQHWbmWr4EX3+E3EVUARU062BeWqHs1MWfQSWzTfoaJ7zYbhgAw0L
	 SJy/Tw1Fhq2wPcb2CvERufjlVzAqs8wEbq0EQ+W7r7LwOm9KefX87iMu7j7a+1gqnp
	 8UzO5pMC8Dri0dLlSoU85FluInkbGSZhtCErim3QhJKYAR5rtvb95B6cQvhQEkvenH
	 D8H5e6Uwc+FAA==
Date: Tue, 24 Nov 2026 18:08:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <20261125000838.GA1194450@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awVV71IbFuYAJDzh@wunner.de>

On Tue, Nov 24, 2026 at 10:16:31AM +0100, Lukas Wunner wrote:
> On Tue, Nov 24, 2026 at 10:04:31AM +0100, Lukas Wunner wrote:
> > On Fri, Nov 20, 2026 at 12:18:41PM -0600, Bjorn Helgaas wrote:
> > > On Thu, Nov 19, 2026 at 10:28:36AM +0100, Lukas Wunner wrote:
> > > > https://lore.kernel.org/r/cover.1794997749.git.lukas@wunner.de
> [...]
> > One more thing:  sashiko flagged two valid issues in patch [7/7] of my
> > above-linked-series (which is now the top-most commit on pci/aer).
> > I've provided a fixup patch for both findings at the bottom of my reply
> > to sashiko:
> > 
> > https://lore.kernel.org/r/av4j5j9-In1uWC8T@wunner.de/
> > 
> > Could you fold this into the commit?  Alternatively, I'd be happy to
> > submit these as two separate patches if that is preferred, with a
> > proper commit message to explain each change.
> 
> Actually... come to think of it, you had this question about whether
> ratelimiting knobs should be exposed at all if there is no AER-capable
> Root Port or RCEC.  I think this could be implemented simply by not
> allocating aer_info in pci_aer_init() and jumping directly to the
> "enable" label.  (Because I think we still want to continue enabling
> Error Messages in case the user or the platform sets the System Error
> bits in the Root Control register.)
> 
> That would implicitly hide all statistics and ratelimiting files
> and may be a cleaner approach to overcome sashiko's objection that
> Root Port statistics are exposed on AER-incapable Root Ports with
> patch [7/7] of my series.  It would also save a little bit of memory
> if we don't unnecessarily allocate aer_info.
> 
> Do you agree?  If so I can prepare a patch.

I folded in the fix above for now, but will be happy to replace with
the approach you propose.
