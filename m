Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031396;
	b=3LAQ2saecfCksP8u/O7OglB2+uDbP2ltXI1NRYmxtkM7FWjUaIEfXlBi/zBRQN/6eY2w
	 LB41yVLKRvKfu24BpGIFKuHk9+JlWS6+dbMFxMJ3nDU3bIGq9hctuanWso8MfmYoRpe6D
	 hy92NzSW1xRzwf8MZnu6KZT1T7uQ3krD5OnMgZkmoWGEq9yDKCCLmcOdQlHzvW6MxvrS6
	 4yQu9a1jOWK6bQAjFOAKgLLjmUsbfpXdcmNtQvxqHmmMsXuOrfoQ1x8Pb3xfflDogAday
	 g4ZMEwk8hFv5V7p8IRePjjc7CzAVAtuUJWc7Qx1huEByO1L/RSAU7MXCx/6S9639nsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031396;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XpUTJKSNd3BKZMuNsk4G3FLRtdV7s45kYttRU4gqcas=;
	b=LUSTWbbCW5+uKqT3aODNAoGJYqv+xM1oM+J/btxalUVY8zxaDVb6oNokhhYvLy3gQR9Z
	 ZL2TZ2jC64+QEdo7h9pV91cgGE2YmdMABNSrMfZ++Bu5VbWqzZM78cymnFTRevsxW7lk0
	 tPQYFw/jiWREZQPXnVf36Mb3fm2M6eiTe5IMS+h3INZcHODwDcvebqfkgU5YUT7UdGUKL
	 gLm4w0EN11MYPjr56SEe/e+BU3kTG5schv+z4jwEHGyfZFhkzf+A866S/ajxTsdHrr55g
	 NNYDsRkm6K+u/wVhkhAyORWkVA9kXGFx1SN5txKbvp8lncowB2uosQ0qpJNFtiY4vIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=demZj214;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85685606A320;
	Wed, 18 Nov 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=demZj214
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D01F000C4;
	Wed, 18 Nov 2026 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031396;
	bh=XpUTJKSNd3BKZMuNsk4G3FLRtdV7s45kYttRU4gqcas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=demZj214Okph6xJpa/01zUcpC44TH2tWspl3ewP38RpUZK/Usoqx9e1ixsVubSSXO
	 JCIiOBOUQb0dwTOGZBIKsU3wri/J8Jqcl//pGCJG0chd0j3HciCxzN158i8tpa1v2E
	 gr1wLsOY7D3E/bGcsfBtKk7iBRZSzmG9+EFVX//i503bzxYB96Q/HD8PnYTdBpp19K
	 F48hTsAvMkiq1LAsN+DsXwYpr8IPXP6ea4uScDktTGCzULUGOHu4kZ4qkHX/VF/pDw
	 KPM2CLvpEMNAC56U+xbRc5sWFNb+YDGckQ1+LcmREDLdtiq5ir9oUxJjCPo1apthpD
	 24lLCWhDkBbVA==
Date: Wed, 18 Nov 2026 19:49:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 11/19] RAS: Remove unused ras_userspace_consumers()
Message-ID: <20261118194948.45293a26@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-12-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-12-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 12:10:21 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Remove the unused ras_userspace_consumers() and atomic
> trace_count as the previous patch made extlog select
> CPER console output by severity.
wrap longer.

Otherwise, if the rest goes forwards this is obviously fine.
However, more to do.. See below.
Given it's trivial I'll just assume you'll do that.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/ras/debugfs.c | 10 ----------
>  include/linux/ras.h   |  2 --
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
> index 42afd3de68b22..838cc689b9989 100644
> --- a/drivers/ras/debugfs.c
> +++ b/drivers/ras/debugfs.c

>  
>  static int trace_release(struct inode *inode, struct file *file)
>  {
> -	atomic_dec(&trace_count);
>  	return single_release(inode, file);

Use that as the callback. No need for the wrapper.

>  }
>  

