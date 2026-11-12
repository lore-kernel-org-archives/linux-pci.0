Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518908;
	b=n3Up/TcKgTSJ0nX8j6DCJKenJdhuXAgaMiUyR7PNS/8Y+ix1Q3iH+tHnENbKhM0oGkvc
	 zgpdLcyEEEz2vPcJRST+c0hi+ilEwdGarSK06jyCLNO3qNT7MWF/VnbnSFXKkrfnkGRb6
	 3mP2eLBKZi4wY4lJUcMDzw5HCpEcdtZK6T5A/r82UsA3SxOEH8jLuyljV/M9t7uvRyuxZ
	 1uWfhzg/QxPt+gslAR7z4ovnguiCCtoVuDoEV+4pwgfeMx2xocA5nFd1++93mZbIReFBa
	 pwVKHvmlpU7RteZI6WJbpHZJTgtJ1N0MFFdBGn8W1TBiP/02kPKM7xeP39JHzUVYdRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518908;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h6Eo0XlcXWzNo/1A0p0/ThIiBGDgrSwqCITWPuHtixw=;
	b=kfEP4cELcF0caC3Ea15C4UZaYVnuLbkDqDHSSJBG0hwDmXvXLbIKz1tK4vNxvVkxGjE5
	 YLsPNkIgReNezohooBsNLjfibLlnYVU79BQdn9qpNHcqlg7ivxEvVjBH4fuympp2YHzMe
	 r7E2WRtsChMSZu7QdO0SInsUrCUwCrPcYw3LFu4Bf5vMU/bJuhXWxhgZsijMlhBIuav6L
	 Anw52G/z8Cwo9Po19RmubhPHcm5yotd2EjeUmMGY0+9lhhJnGqIbA7f87Y41vyQk9WQez
	 NsKABdlul0lVeid9DuKFg1efUv+1L2hpd05HEgdqXapp/FpYzrM8FrYSBVaPj/7angA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiilfKCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AE606A31C;
	Thu, 12 Nov 2026 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiilfKCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9081F000C4;
	Thu, 12 Nov 2026 21:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518907;
	bh=h6Eo0XlcXWzNo/1A0p0/ThIiBGDgrSwqCITWPuHtixw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fiilfKChROavlxHT1KkCFLjLthg63yVRIg0vhy9Dr0ZR1LkXb3pdZM3wT5cu++9tB
	 FN9R0SESt7jS6U7fcprTYEvbsyvmz/pTgcNzwDR5SNsCtWdhj2FMb+NaoiVS+I32WK
	 bp8V9luAj0fhjw0ZvV2Dx4ksGq/IfVr69YsZMy7dDeJaxS9+X3cJE6c4qPXLqCJxb3
	 LwQ5nhIo6idjJWYCZnWp13ZDgZpCjEEtAa3TMB2qMkBjLbXgZBzOvltK9kDQ3WIUqq
	 nN66x83jRwgD93ogX39X6lqkoZxvEPLwxg7wDXHj02I2v5dOJaUgKVhax4d/QbH++9
	 /NLizGn4uFeKA==
Date: Thu, 12 Nov 2026 15:28:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/25] PCI: Add SNIA SDXI accelerator sub-class
Message-ID: <20261112212826.GA907393@bhelgaas>
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
In-Reply-To: <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com>

On Tue, Nov 03, 2026 at 08:49:42PM -0600, Nathan Lynch wrote:
> Make the class code for SNIA Smart Data Accelerator Interface (SDXI)
> functions available to both C and Rust code.
> 
> See PCI Code and ID Assignment spec r1.14, sec 1.19.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
>  include/linux/pci_ids.h | 1 +
>  rust/kernel/pci/id.rs   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 030c86dd6d67..dcb26f52b5a1 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -154,6 +154,7 @@
>  
>  #define PCI_BASE_CLASS_ACCELERATOR	0x12
>  #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
> +#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
>  
>  #define PCI_CLASS_OTHERS		0xff
>  
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index dbaf301666e7..d714e4b83852 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -292,6 +292,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>      SP_OTHER                   = bindings::PCI_CLASS_SP_OTHER,                   // 0x118000
>  
>      ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
> +    ACCELERATOR_SDXI           = bindings::PCI_CLASS_ACCELERATOR_SDXI,           // 0x120100
>  
>      OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
>  }
> 
> -- 
> 2.56.0
> 
