Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E60320CD3;
	Wed, 11 Mar 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272376; cv=none; b=WEaRWw902EadZethpZiwbyM68SvzuhJd7S8oQV55hXZuz5E48xj6ReVHzarvJ1Q1f0Fv1CqM0TmuELDKsS9BNW2utRX4hm+xRdOXcxIzmuxrrrTMj5k0i4HXOOJOw7LsgRNP0EIVs/mf7G0w/e5YMZNUoec2XQhehCio0QYUwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272376; c=relaxed/simple;
	bh=L3fQLDOWRQjeE5U95p1awtM7nH7owvRGTm+zfOUf9ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujroRwcphmJEMCSZ/AjBjVXWav/H26Ny0iXLFAJpHp46Hgj+InYAmvzmy+LQVILuAX7TF+ce4vhpThuxWaBTZh6C/+kN6QRFMKvfIxPpMmHbFnrcVSq0y4Agfkw4Fnvch4PJVpDVyrgxRJjWssRb9VuijRkcF3xPbY99IbANDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id D4FF03F535;
	Thu, 12 Mar 2026 00:39:32 +0100 (CET)
Message-ID: <63ba7402-a0f1-4203-8d8e-9b909003b9e1@hogyros.de>
Date: Thu, 12 Mar 2026 08:39:29 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI/VGA: Move pci_set_vga_state() to vgaarb.c
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20260220194943.3541702-1-bhelgaas@google.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260220194943.3541702-1-bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/21/26 4:49 AM, Bjorn Helgaas wrote:

> pci_set_vga_state() is only used in vgaarb.c.  Move it from pci.c to
> vgaarb.c, make it static, and remove the declaration from
> include/linux/pci.h.

pci_register_set_vga_state() would then be exported from vgaarb.c -- is 
it confusing to have a function with a "pci_" prefix inside a file where 
all others have a "vga_" prefix?

pci_notify() in vgaarb.c is static, so there is obvious precedent for a 
"pci_" prefix, but that's not externally visible.

Other than that, I think it's neater overall.

    Simon

