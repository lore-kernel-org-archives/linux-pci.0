Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087041;
	b=Zh0+4837RFBW0tXwLTZsJm1Jc7v2XXR5ZcWcIxkWX+IoRINzGE1im6WnagPyk1a1/689
	 QT0eiC6YGsl1+8FHNVegEUqNHQOeuLXfmRPLYcoMr8f2fTxSbZfUu2sRULSLfkfpnnalF
	 E046JAzcNAN80prXIuegCS0H5lOYyScBX6I6B4I4ykYXK+PEdb5G5s2JFhQzm3J6iDhIH
	 G5ti2Sa9QTxmvZBN+Pyn4bkJKFnU6qqARSnCiGxBjzO6p3cxXphcIgqMNpDRwytjl1/an
	 cRJrHrzJibuKvH2Eh7Vxk/+ahlsAI8UVpyYcUh/KRLAeTSDn0TxNem3orWKHmoQfiuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AobPWOfmzE3HwwF/Li0VAD7XrzGxn/GVq4nxLwzb/JE=;
	b=NQ3fspDJsDXuaElnRO2gygRgIyi1PkZbu7ErPuwQuRoMJRC5GtCm92UU0wWoF+I2D0ns
	 /xNuyADbyL9JeBKqDmnqKpK2yTDpOMcK27uEAgTXtaBvbu9dRWodNk4y9Z3rp9GIpiJAl
	 gLPcjT5eLPJ2ROXOFI/aNWznu83ahdWh62MYoUhlNPJd4cuhZCkiEVAQjIzpZBuqM+31j
	 L0Zk7y0qfBMih0WGBRHO9ROLcE1blxuniBF69lmCPAiFLostF+nQrCeUzg8pgkMicrMth
	 /WVJBwydd4lEPGRMfxny05dP2ClkpwgSj4e3JoOzk6hSXpRmZpdKZmarZouYVzs5pjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoFAuLBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CB606A320;
	Thu, 19 Nov 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoFAuLBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1D71F000C4;
	Thu, 19 Nov 2026 11:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087040;
	bh=AobPWOfmzE3HwwF/Li0VAD7XrzGxn/GVq4nxLwzb/JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoFAuLBLyrbCp46UN1DqjdfvdaUEF6buOWWn7dJXM5u7SBuptSdSeSEjIjPSlto36
	 ep6RVRQdAMkHPSbyStWx34/QptijWC/8sp6xbkMGTPj1iECx/8xExZdYtnFhSe0MdO
	 D4B5NwVRjNWBrHvndeCdJvat6B4dl2QB12Qvu3ewQF73QtGI1vamPYZg+pn7BXRvbA
	 KiML+OE5AiVdQDol/CqPlM4uKF4BI3gOaTddebE3minv2yBivpknT8m3rQWoj8kGw5
	 6cvAOO2zzwTspWVc0dBTqi5QR73Yb7ZdeHf/ClDE9ZhZCnLKHpF3VFrzsEnpSLCJTH
	 274YR2125V8pQ==
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>,
	Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live Update
Date: Thu, 19 Nov 2026 13:17:06 +0200
Message-ID: <179508650609.356641.3313376675131770414.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 18 Nov 2026 22:36:51 +0000, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11
> 
> This series introduces support in the PCI core for Live Update, enabling
> drivers to preserve PCI devices across a kexec-based kernel update
> without interrupting the device. This lets devices, such as ones
> assigned to VMs through VFIO, keep running across a host kernel upgrade.
> 
> [...]

I updated the lu-pci-preservation branch with this version.

I'm waiting for Alex and Bjorn to confirm they are happy with it before moving
it forward.

Applied to lu-pci-preservation of liveupdate/linux.git tree, thanks!

[01/13] PCI: liveupdate: Set up FLB handler for the PCI core
        (no commit info)
[02/13] PCI: liveupdate: Track outgoing preserved PCI devices
        (no commit info)
[03/13] PCI: liveupdate: Track incoming preserved PCI devices
        (no commit info)
[04/13] PCI: liveupdate: Document driver binding responsibilities
        (no commit info)
[05/13] PCI: liveupdate: Auto-preserve upstream bridges across Live Update
        (no commit info)
[06/13] PCI: liveupdate: Preserve bus numbers during Live Update
        (no commit info)
[07/13] PCI: Refactor matching logic for pci_dev_acs_ops
        (no commit info)
[08/13] PCI: Save and restore the ACS Control register and Egress Control Vector
        (no commit info)
[09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
        (no commit info)
[10/13] PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
        (no commit info)
[11/13] PCI: liveupdate: Freeze preservation status during shutdown
        (no commit info)
[12/13] PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
        (no commit info)
[13/13] Documentation: PCI: Add documentation for Live Update
        (no commit info)

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.5

--
Sincerely yours,
Mike.

