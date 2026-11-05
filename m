Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906889;
	b=tPhv+gQLcBBQi5l1gSEJrPEThM+KdoBBdFu+UydrC7MUqb/gkwO9GDgpy60YnrWz6FDL
	 nMxxdajCst2eV3ui/e12gKFZ2skuCblYyFnXRUU5Skc6aXLHW7WOZ7I0bPQxlmJNNIUCR
	 EBBzSsAEGDlL5OACF2tmFTt1MiSEuTIg8i0da4wiORUeHhe+vfUH8FSAdDdjOxTX4JsO9
	 znEK3SrhgsypzYjSoHV3nA9llAPETl0u5hcQ5e5tMJD5SBS20PU8NmLlR6I15AxkpKzkq
	 CgQeFOGTu3YXEhB8iwNo0nMOv3tZ+1N1IQ32OKyps98x0AEaYUtzCDYCRqkA0EPMahQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906889;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mO682UCX6enFS5CYcGGQSUIzBPvElDIKploJcGmXk3Q=;
	b=SQkY8fvYg/5cHmcIhQsNoPYiAEXdmBHBTGEYh64ajivdr1rR+z242/8gDGJ0MNa5IASN
	 I+UZZiekIiY5NMAXHtdJmc+fi42fKdUZzxW/bC/ILO9JSST+cDemxF+wZ8WfGxYfmfYdA
	 +Vc84tXDS4VGyVYOuF4LDSBIEtliom7nguRLuV0vziaXbcXceEDL8SAI5ktn2CfstYWc8
	 Cnvwoz5+kNnqqX04zRpyQQNPB78b6Oq79Opz+hq2c2sa7kzHWWjA3BsxZh2HtPaQXczjJ
	 5Z5DFVBVCEgj6jIIuJrD2kqrPZjoAkDJnpoIYJjwnl55XLqKWRFboQIsKOZEpdmzdiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0+F6HP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECA606A326;
	Thu,  5 Nov 2026 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0+F6HP3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848CB1F000C1;
	Thu,  5 Nov 2026 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906887;
	bh=mO682UCX6enFS5CYcGGQSUIzBPvElDIKploJcGmXk3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=K0+F6HP31Z9thwXpi7+IZBF7hYc/SUDrj+EblqIsTI1pGumRdMdkCcAy5LyIj6Zy2
	 SzxFlpMu/7oVAVu/noZRHf1doc3xjbMF/9GIJCOyEl3z0Jdfta4hOgAyDH952Zmc6s
	 pmlqin65sg7ffWpXuDnzgKNCSGD7hc40NLFIzZudKBvsWO+KYMbGp+VzXoFL83aMGL
	 d/tckltpVJaSs6+dHLVkZXICtmfmUKlrzmh/vdnCMIUH3YlIyU4Ge2iyqOCkz0aFFs
	 eBaBo8xCXnQR9HVD7yTjr0TADNfa5aCEY+gI8ULypPfmPBnPXuNJkTaCJow2swZqFR
	 710w1Lh0sYIqg==
Date: Thu, 5 Nov 2026 13:28:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Vamsi Attunuru <vattunuru@marvell.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: octep: size the interrupt name buffer for the full
 format range
Message-ID: <20261105192806.GA1551537@bhelgaas>
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
In-Reply-To: <20261105092705.3099201-1-xujiahao@cmss.chinamobile.com>

On Thu, Nov 05, 2026 at 05:27:04PM +0800, xujiahao wrote:
> octep_hp_request_irq() formats the interrupt name with "octep_hp_%d"
> into a 16-byte array.  The prefix is 9 bytes and a full-range %d
> argument can add up to 11 more, so the worst case needs 21 bytes
> including the terminator and 0-day reports:
> 
>   drivers/pci/hotplug/octep_hp.c:312:53: warning: '%d' directive output
>   may be truncated writing between 1 and 10 bytes into a region of size 7
>   [-Wformat-truncation=]
>   note: 'snprintf' output between 11 and 20 bytes into a destination of
>   size 16

Thanks for including the warning text.  To make the git log more
searchable, please keep the lines intact even though they are pretty
long.

Also run "git log --oneline drivers/pci/hotplug/" and match the
capitalization style.

> The values passed today are OCTEP_HP_INTR_ENA and OCTEP_HP_INTR_DIS, so

OCTEP_HP_INTR_ENA (0) and OCTEP_HP_INTR_DIS (1)

> no truncation actually happens, but the buffer carries no margin over
> the format's worst case.  Give it the room so the warning stops coming
> back from builds that cannot narrow the argument.
