Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265D2E62C6
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269508; cv=none; b=nMwdQLjYlkZ5dFoqtFzamEme+pCbDjauJoUBBdPeKNsz+kl0Hnhcd7KYVaPbl3+MUBX0XnLQ039gQ/dJdU0p+VLSLa7gXr3RwaidKZKzovshQK6R02SN3ZXB7uQk4cBhWvbvk+ILBCrR+kq/ynOP1q3WeJpCeN9whg5UnKHBkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269508; c=relaxed/simple;
	bh=V8oPXi0MiR7YmWMM8393UAjw/gNA9m9h98eSS64krGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYGQ0IRsAZE7ETgOMzQqieGWnNCXTmGoMm/WIGx2RUxVc6bdUA3bfST8gvnPwalsXClP1QQUBnKWc11krqLnOHjblg39ywn1a7YxveSDVkO7N8ijatDEfCysEW4VeXJNdIF0n8Fddh92i3XCtM1eSiFtsILcxRdP5g9+OQrTxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id E74563F1E0;
	Wed, 11 Mar 2026 23:51:35 +0100 (CET)
Message-ID: <30fdf953-76b4-4aa6-b430-b9c73f91c8cb@hogyros.de>
Date: Thu, 12 Mar 2026 07:51:31 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] vgaarb: mark vga_get() and wrappers as
 __must_check
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260310200718.GA786702@bhelgaas>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260310200718.GA786702@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/11/26 5:07 AM, Bjorn Helgaas wrote:

> vga_get() is implemented in vgaarb.c and is only used there.  Can we
> drop this declaration and the stub below, make it static and
> __must_check in vgaarb.c?

It's documented API, and exported. If we make it private, we need to 
export vga_get_interruptible() and vga_get_uninterruptible() instead.

    Simon
