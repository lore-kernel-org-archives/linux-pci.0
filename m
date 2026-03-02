Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFF331230;
	Mon,  2 Mar 2026 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439651; cv=none; b=C3a9qEkBN5bg3AOcHGG6efZ21Kzopv38VZty4SE3HGLzdNEZ2iRNR7WnRkwKuGJfZaQpND8qhnwTO0HFkJuDxWu+n8WwALvuTU4AS7b6+YjERl2bDQFRvubQ/UEF/PlZo2FHt6FsVZrOHfS0JyYBwDlGoGPyF0NlT1iLCfYocN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439651; c=relaxed/simple;
	bh=fDYXD4VD2yR75zYY6OOj5F+Auon5DcJhD3j5sfQ3CC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWzrNlVyjmjad3SpSXVMve/c0+/j1PD4tN1HHxcKdIHIdAGPPpXjA9X5JnHQ6HC8SIlb/0NwUpvXk/rt5f8NQbDf3ZaXTH0YG2bksU3vbWxHTjNqSWbHCLm9dUa53ozsEYO9Rf8h8mUKs/TMRr4d4yl/zhdIM1AYpLR0X8sV0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSal0vMu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSal0vMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C67C19423;
	Mon,  2 Mar 2026 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772439651;
	bh=fDYXD4VD2yR75zYY6OOj5F+Auon5DcJhD3j5sfQ3CC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JSal0vMubrF1Q4MhTYeux4kULZj3+Mq5ius6q9I6mT7IHACzC5sY37v0FNyW6uEvK
	 f300PjEl1mdnqpBvh7azNB0OhNz866lFp+miFoEGWyQTtpWmzNVI+iSDTx5hEUMRgB
	 +/YRTqlcoyfWCj7gEiDPCLD3ODRfIAQ1jqBaTrdE/MYQHfk/ijBBT3YIjc9xBXymU8
	 JUsm2LRMn1+VgTIX3omzsLRfVfBF7NFpOCePTWRNge+/QFZfqiubOAhaB+0TKbETbE
	 uThjsB9CBdWgzhc+WrLMq7RPupdfVlUO7cQppmCx+uX+fBrVYozSgpedmCaCg7TcJu
	 braju7VbSLsQw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Melody Wang <huibo.wang@amd.com>,
	Seongman Lee <augustus92@kaist.ac.kr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Denis Efremov <efremov@linux.com>,
	Geliang Tang <geliang@kernel.org>,
	Piotr Gregor <piotrgregor@rsyncme.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kim Phillips <kim.phillips@amd.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Claire Chang <tientzu@chromium.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH kernel 9/9] pci: Allow encrypted MMIO mapping via sysfs
In-Reply-To: <20260225053806.3311234-10-aik@amd.com>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-10-aik@amd.com>
Date: Mon, 02 Mar 2026 13:50:32 +0530
Message-ID: <yq5aa4wqtzfz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> Add another resource#d_enc to allow mapping MMIO as
> an encrypted/private region.
>
> Unlike resourceN_wc, the node is added always as ability to
> map MMIO as private depends on negotiation with the TSM which
> happens quite late.

Why is this needed? Is this for a specific tool?

-aneesh
