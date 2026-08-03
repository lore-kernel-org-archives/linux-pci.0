Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2AA3FCB2C;
	Mon,  3 Aug 2026 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756416; cv=none; b=JWN9Ub7vtfbZMXu72luf2aZrlZY/U3Un9t5Va0YqG9R8aKNs5RWClCj17zU9+3fsLikFMm3QmjdphvXG1AGZ1lJTTn0UGulbNlZWKEA7heMSBFPmf8EREXps4Sn9tT7IyVxj2G4mohK2g3T+GEH+7Q4lYmLHQ6717+6L2iIzSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756416; c=relaxed/simple;
	bh=73mJ1z9C5rmOtG4AkqfRQlbLhQEbz+mglvlAeDNaqYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axJx4kxXddUFR4WiIRvGMwEwQVmwwFE9tWcVgb64aYKdbAYXFzIwlezT6k4/dWQ4LPemaEZGxzUtRyY0maqDQcEl4H5rDcz78Naxj7vV0DN5mFT1LjRYtvdhPzm9Cl6nGBbduoAYeRKDxaeWM01sqL1A+Pbhy9fk7i4cRYhirKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.92] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 619953F202;
	Mon,  3 Aug 2026 13:17:46 +0200 (CEST)
Message-ID: <be4bffdc-7e41-4fa9-a8df-c41dc6357225@hogyros.de>
Date: Mon, 3 Aug 2026 20:17:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI/IOV: Restore initial VF BAR sizing after VF
 ReBAR
To: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/3/26 7:30 PM, Marcin Bernatowicz wrote:
> PF drivers can resize a VF BAR using VF Resizable BAR (ReBAR) support via
> pci_iov_vf_bar_set_size(). The new size persists in the SR-IOV capability
> config space. A later reprobe / unplug-rescan / next pci_enable_sriov()
> then sees the inflated VF BAR registers, and the PCI core reserves MMIO
> based on that size multiplied by TotalVFs.

Would it make sense for pci_enable_sriov() to check for a ReBAR 
capability in the VF and set it to the smallest possible setting, so we 
get the same behaviour regardless of whether this was cleaned up correctly?

Also, should it be "previous" or "smallest" size (in order to not make a 
missed cleanup permanent)?

I'm a bit worried about POWER, while we do have lots of MMIO space, we 
also use kexec() quite a lot because on several machines, the bootloader 
is some ancient minimal Linux system.

    Simon
