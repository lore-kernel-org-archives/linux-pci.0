Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566490;
	b=OD85tzws9qf7jNHlQhi/PJj4Js2woD8OQl0s2jhojN/Fc6SXwxetH0R3S+NGC8Bl7oIu
	 tWtbRxHR7+QTupNOIYoTP8Ge99FA9PJSPeaJ/R+GlEIN4k8ZHtkUgXldPl+WuZ1cZYSlO
	 pruG9mYLHCN+519mw3q0GzEEx2PWhRlJ1TNPagrMrsOd4CQYAeuWDXLYu7/fyd39GoICm
	 PrKSq9Ot+L0ba2CbqJ4p3zjw/ksne5FudJgXeZmwqvujHBfXxKS1tbpRVx+WprYyISZqz
	 CtNYycBb7eeVhCCr/erhDxiD0slc5q3autbgDhgYCqRHRx8gTJgUXQFRKorwZCD7NwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566490;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ShzhlyGDiRC7J5U37WWxub5Q+gr6NCnkh429eHZhijk=;
	b=5dxXvpkTJ7rK7FGfltUP3uiB3wdydNUHxEMnDNx0CDNk3laPihesoQ/LwfZFrrug/Q3o
	 pMN5LBwBEP0e/I3JE0cCncFy/rq29CgfXOzRz20E5R0ma4fh/t/lcO3cTc0FqDgk6dyzw
	 OieRPeh0RvmI8R0IyUhoquInXyio2LNPvbvs50Pxdb8hDOTIVKU7FojQi20mNKeddmwYv
	 XFjNZkrX5zVt4x+NjEMp7UtHdZGpWno/ix9HqpQL07zWwpF39w3AAmH/FgfgWGevj6CNf
	 uQZeKBaHIGZM+b5Tw0sCn5K7sVRPSZj9y/M2LYj3j/HNnzqUgfe7APA8VPc7+JIIrRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPW74Dx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C7606A31E;
	Wed, 25 Nov 2026 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPW74Dx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84C81F000CF;
	Wed, 25 Nov 2026 00:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795566489;
	bh=ShzhlyGDiRC7J5U37WWxub5Q+gr6NCnkh429eHZhijk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bPW74Dx341iMuPCuB42uOqQiqXrd1Uo401JAnEo1pz0vZ/U9bHXGAplacO6KcZ0Nu
	 EQ/rrlSFaA/uV9GFJkVqgiOFYhIXDOgIOaDBv6snShD2WoB8HZHlnt+Yx7VBFGZetr
	 JE69pQAvNPUIbtDtaprkwnpfZZK5Bdt5TmXdyg/4QN54CXQo6WLe6fBuf+h7mw65Wo
	 XHMpewH9f0Hl8f+mERZn5R+Z4h8nF2f9qD/LvtGvG2i0ey2G4NC/+S+9YyCfGOzKgF
	 KDcVRC0TWQMwzWiHvelRSNmced/1wVabvOyISlrKNDs6X+C2nrD8IlbcW+ju91QiqL
	 ZK8MOHHJQzx/w==
Date: Tue, 24 Nov 2026 18:28:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] PCI: Add Lane Margining at the Receiver debugfs
 interface
Message-ID: <20261125002808.GA1198022@bhelgaas>
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
In-Reply-To: <20261124174411.4183038-1-rathodpriyank@google.com>

On Tue, Nov 24, 2026 at 05:44:10PM +0000, Priyank Rathod wrote:
> Hi Bjorn, Ilpo, Lukas,
> 
> Gentle ping on this series.
> 
> Note that since pci_force_enable_link_state() and the bitmask return
> value of pcie_aspm_enabled() were deferred before v7.4-rc1, v7 as posted
> no longer compiles on current pci/next (and has a minor Kconfig context
> conflict after PCIE_EDR).
> 
> I have rebased the series locally onto pci/next, resolved the Kconfig
> conflict, and replaced those deferred ASPM calls with a small
> PCI-internal, reference-counted pcie_aspm_inhibit() helper in
> drivers/pci/pcie/aspm.c (leaving include/linux/pci.h, pci.c, and
> pci-driver.c untouched, and preserving existing ASPM/L1SS/Clock PM
> state across sessions).
> 
> Would you like me to post the rebased v8 series now, or hold until any
> broader ASPM API rework settles?

If you could rebase it, that would be great.  Unless it depends on
other changes already in pci/next, you could rebase to v7.4-rc1, since
that's what topic branches are based on.

Bjorn
