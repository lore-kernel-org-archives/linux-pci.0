Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907677;
	b=VzGTf7i3MUkbf1zzrnUUo2RfzdOg92Qe7jOi4HpqUTod5ZD8wYuf3KDLRTkkOlHsOQWY
	 ucRcUysFoXQJrh2RwqhTMkUJ9GoT3Fs5pl2Ifax59R7M0Nx5sziB+Pqa1Yznyzp6M32j/
	 yUsSiQEbvyCZE8I6iIMtq+vCzKt+nYN0+SEN5/xkKovkgdOiUajlR9qGDsbhcAGu1si2K
	 xB+yjr6qOzBTehpoEZTSkxGF0SdpVp0elCGGGwV5PE3WCuHWI6relKI+i6vjzCconOxeJ
	 EE5e0vWz+abWBAZOblPxMrEMK4TuGItuSHw1JDVAb75dKA2B4PB2DytjE/3JmnyyBqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907677;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7xOA7/MFtPGvMkCRzH2IZM+Zp+q2YHj/nln8ZoTRBwY=;
	b=1GBwoZoA4vxp4nmhTaOOC912Ofv+0d/hGZfL0hVv47HNvNlFSNOP6D7F8Pr0FZq26EkN
	 1fQ5PB/Q1MS9WfHFe+gT4nN3P4yQIRyG7YDbRQenVS2HdX5VIu/dF6I8o3YBRhNnDH+rr
	 hEestZBI9ySvTgaZFM28WPkRrQr9pyF5C9q2bNJNSdCPZS6S6pJKUZ5RMmHrh55ZzZPyk
	 W6bX3cJ9GMQwVggm/FzouYEcQWXSWH7vYbuPGKTuK8rrGM5tJDyASU1dJrY08m8VtnE9+
	 OoR2YT4yemacv9XsB56DDTWpUT+Xt+yYCrbxm41IXjxtR4k8D6wzD2DflWa1JN47+pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PagCPc1K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433260772A9;
	Thu,  5 Nov 2026 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PagCPc1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CD61F0089F;
	Thu,  5 Nov 2026 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907677;
	bh=7xOA7/MFtPGvMkCRzH2IZM+Zp+q2YHj/nln8ZoTRBwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PagCPc1KLJLvqSP1ak2XTtOPSr3K9Q5Ap2/nOehIHIEciNiB8UdpA5afRCvNwzLH+
	 9EgbfaeT61Yqk6r+hWYx7RTy5aa35aam1ySzOL6dKjUN1CicPkZFkQC0ognTOsud0/
	 4MM1q5mqwz+5na33Q5pThHnO6dPG5NT2b80JCa7/qHdLEIde0gdnEqZQh/rWIVioRP
	 1NzPcag3YCPc66Mxx95xh4VjFI4uS0+80hwkVqvj8V4u7IuJgk7vtAEA9p/loGt5qi
	 kszJsuHBMOqZrPhPL/yA8DsE04t1jXsuF+dqDe9tuGl4Ha5HFZtgGrGnsCeFmVPxBq
	 SowR5BhKazQSQ==
Date: Thu, 5 Nov 2026 13:41:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: tglx@kernel.org, bhelgaas@google.com, maz@kernel.org, lrizzo@google.com,
	hch@lst.de, changfengnan@bytedance.com, namjain@linux.microsoft.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Message-ID: <20261105194116.GA1553387@bhelgaas>
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
In-Reply-To: <20261105182706.3700908-3-kbusch@meta.com>

On Thu, Nov 05, 2026 at 10:27:06AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Skip the read-back that flushes the MSI-x mask write. Parent domains
> that mask on behalf of PCI/MSI keep using their own irq_mask().

When you respin it,

s/MSI-x/MSI-X/ to match spec usage
