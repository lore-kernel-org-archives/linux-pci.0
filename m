Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0363EEAE1;
	Tue,  4 Aug 2026 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883081; cv=none; b=CT2HGcCAvKUu/Tyb72NXx/hgI9uZiBC0Xy/iDVD7lgdjNoRoFm7WOrIvw3mbePmKBU/Pwthc0Or9RmX+i+p77KN24qRsvqxcPmxRZWpNsNP1KUbJHnh1+jw6Uz60mTmRDPZ9KcV1z6HBxXy2D4b/74QmbYTfQSgvtZqqIxpsc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883081; c=relaxed/simple;
	bh=fF/aYQfn27aiUE/it3NnxdswOz468cJ6Vz2/iC9xsJA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=YsuEepeFTAahX3JzTKpsvd0m8EfxDMnLKw/NwXiBa4um8OOKxzxEyqzWuK9sYFfp9YeaZH2UQyr6Alyu3H500W+7tik+mBQ5uf+L6TRQ89dKxWYQRliIyjpXZdq/rfDQhoTWNkkVoH7/sy5u6Zyk3jZjSnVNqn4zMo/zVfdeF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=a5cjlzLR; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="a5cjlzLR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=74dZ4XlfwbVgk/WwEwM/+jCir8WAbMWTR8p07XWwCi4=; b=a5cjlzLRv1WuQ36jen9aq1SwFZ
	PdMFs4rAJZ6GoZ1usyLwaB3Gsfgkz5oHmgJ/4//OiCQMOIOq++Dd8a1hWnedB0Sw6FwIPMsw6gsAr
	GdzJF0sPn062Pxvhv47VecqJgZ9Um5PTci+RWCXY9+4oagQfhxuE8tMRkqmA2tH6Hqsxm7nQIStPW
	eWqVDvuPZ6qMtNXWm1kIC5/3Eet1z6Bt5JkeU4RFu3+KX4sySzJyUKfbBlvzkiLTuOIUWz8RrDMkY
	239dgw6/pEEtu3YWxKuRIlJDbDdEZh+6me4VrQ51yh9U1l4kn9fzP65b+Ho/eohLkXKBjK871LxM9
	SUu5BGcg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrNlm-0000000038a-0Hp2;
	Tue, 04 Aug 2026 16:37:58 -0600
Message-ID: <4f2b4d0a-0838-495f-9d60-50a2628e5448@deltatee.com>
Date: Tue, 4 Aug 2026 16:37:57 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, "Claude Opus 4.8" <noreply@anthropic.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-11-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-11-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, noreply@anthropic.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 11/13] PCI/P2PDMA: Add KUnit tests for ACS routing
 decisions
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add a KUnit suite exercising the ACS peer-to-peer routing logic:
> 
>   - pci_acs_p2pdma_decision(): the full PCIe table 6-11 truth table,
>     including the Egress Control Vector branches (bit set/clear, with and
>     without Request Redirect and Completion Redirect) that require a
>     switch implementing the Egress Control Vector and so cannot be
>     reached on commonly available hardware.
> 
>   - pci_acs_egress_port_valid(): the vector-size boundary, including the
>     "size 0 encodes 256 bits" case.
> 
>   - pci_acs_egress_ctrl_set(): driven through a fake pci_ops returning
>     canned config space, covering target Port Number extraction from
>     LNKCAP, the vector DWORD offset (target_port / 32), the bit position
>     (target_port % 32), the -ERANGE bound, and the unsupported-port
>     guards -- all without real hardware.
> 
> Run with:
> 
> cat > /tmp/pci-acs.kunitconfig <<'EOF'
> CONFIG_KUNIT=y
> CONFIG_PCI=y
> CONFIG_ZONE_DEVICE=y
> CONFIG_MEMORY_HOTPLUG=y
> CONFIG_MEMORY_HOTREMOVE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_PCI_P2PDMA=y
> CONFIG_PCI_ACS_KUNIT_TEST=y
> EOF
> 
> ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>     --kunitconfig=/tmp/pci-acs.kunitconfig --jobs=$(nproc) pci_acs
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Assisted-by: Claude Opus 4.8 <noreply@anthropic.com>

Great, I like having Kunit tests for this kind of things. Thanks!

Reviewd-by: Logan Gunthorpe <logang@deltatee.com>
