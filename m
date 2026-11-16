Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834910;
	b=jVJK1v7FB4mbhmE1uxXoy82tR6rJrQTCvdpAF7FYzqjfkpZtQKGR9k8X7ceZkpF7I1Gd
	 fvh8gNuDH5B+1gwa9AZJu5s9EYaW7d2PUkqY/yf+HOlQBBEqordi7oIv4fLDRwFNGXyr8
	 1ontqlivIDRb+PdtdGO3V8VRauezqqNZTwt7KBbsWZaLSo/bawFYiIApfJ8M+tJDaQLuR
	 X6iv8Ztf/jwpLEXVMaQQ6xfGEMY/s+sKsQnTx2i2wuNX9TrDj/XpzIyU8qa8H/gTSKVRT
	 LUmDXl14xjgpcuDfAVDsMiR0LWCzMxJzkmUPSulRZIHh0tFEhYPUMDRBx4J/5YO0cHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834910;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=IfCxZHy69bdPZ8Ej4wC+oPq+4aCQEr7V+YYajwUncTs=;
	b=T1a3itiXL+XG8AWootvmRJCz/FxCRsNKU7dCs/vj+ahMM/sXNvpckfVR1/F26bb4vujR
	 NcHLCvCPhUGbhabSjhjXWUK4lzm90TdpTlT9x80AnrSY7Ek+1JaFrYjjSkpoXt5/XDLEM
	 720Q+7Vg2bdvkCK7SFTP1XCpRL+2BH0FrCsz3/8eSV+NB46K/B0NZd6jtYiZ1rKvLM8ca
	 QitJ6n+FZmHeo5/zHKYpMOyF1jmeetDrYBbohlXsIMa1BPtZeNxcSR3cboixRpmcSoaIC
	 NnTQXRwJC1EJAFRtUvweh4mEcPYtZP3U968I5yvuyQBOombp3N3UgA8FhJPf5Z7wKGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDx5LTt7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF4606A899;
	Mon, 16 Nov 2026 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDx5LTt7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589361F000C4;
	Mon, 16 Nov 2026 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794834909;
	bh=IfCxZHy69bdPZ8Ej4wC+oPq+4aCQEr7V+YYajwUncTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dDx5LTt7GLsxbJtkcvvnQWmq9YXgl93SjNgbiKVNAff40Udc0uUilmUpNsrs/CnJr
	 ZKgncSFTEa9QL7Uat+IIZbuHFTasffqHv95IFS5WuWO0CV6dnmhZ+Pt8GvDd/RTiZL
	 enhEaEuqSH2Q6BsUIPm0moqEbyxMxMJPSE5lZvoPj/T+vRkM6h16o2IdkZKN9pgu7Q
	 1kJV8TfehzoX6spiBN9tyEzweQ6ZW8H3j0m69SJLEHKM0fn/exw3QDwH0ODGQkdZ65
	 xFwLMrS0PJQVOfJkA6ocSzNSHvjNQVotZZD/TcferKI89bmNhXKI9rBDCD3rz/XONR
	 xiFnzoDXasHGw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
In-Reply-To: <20261116130055.GB1850935@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
 <20261116130055.GB1850935@nvidia.com>
Date: Mon, 16 Nov 2026 18:45:03 +0530
Message-ID: <yq5ajymcyl2g.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Nov 16, 2026 at 01:24:20PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
>> similarity index 99%
>> rename from drivers/pci/tsm.c
>> rename to drivers/pci/tsm/core.c
>
> What's the point of a subdirectory if there is onle one file?
>
> If you were to move it to drivers/virt/coco/tsm-pci.c or something
> that would be more interesting..
>
> I think we are going to delete most of this file, right?
>
> I'm also seriously wondering if adding sysfs to pci devices is even a
> good idea. If there is only one left we can just not do that. Then we
> don't need most of the file..
>

The complete CCA patch series adds the following files:

attestation.c  core.c  ctlv_attestation_pci_gen.c  ctlv_attestation_pci_gen.h  internal.h  Makefile  spdm.c

The final implementation is spread across multiple series, and the
attestation series creates drivers/pci/tsm/. I suggested making that
split early to avoid conflicts while these series are being developed.

-aneesh
