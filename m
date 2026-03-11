Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDA1D7E41
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271793; cv=none; b=eEhSxjp0+qS+Ja1qFxBhfmoATycc54SgAxsatS91FWrLyV0WJfxYAJ6j48mW03SmwMCcSwPI1egHs6OpYMzDx+DptTEcSfSy6bE9wG+CZRws1LNuBGBVx8UH3oSWdm0BlkxxNCTdFNan6K9HTN0cBGRMinLglg1hunrkurFKi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271793; c=relaxed/simple;
	bh=8BkAEsdQyXzsQYydpWlHcTC11zSDzZFouPLtgX9lMK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHFBTL1Lj4Ysaa9Qf0YMfTPfT6XRYvTjTzDhfjYapE7kBkXF9gyd+cOElniWWuGhxMYlHSXu8zvFqUfD/djgtyhN4Lo+zwQUKlbpH0KlfiNC3KKCiY5y0thSja/gqjKgEhIP1qP7AKOYHUXZBabXCgdyD65RjHYF4KUj+iT9FVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id ED4843F535;
	Thu, 12 Mar 2026 00:29:48 +0100 (CET)
Message-ID: <5f86ada8-12ea-4103-b933-0ff586b7133b@hogyros.de>
Date: Thu, 12 Mar 2026 08:29:46 +0900
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
References: <20260311231433.GA1083635@bhelgaas>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260311231433.GA1083635@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/12/26 8:14 AM, Bjorn Helgaas wrote:

> Is there other API documentation I don't see?

Only kernel docs, which would be annoying to edit because vga_get() 
documentation is lengthy, and the wrappers' documentation just refer to it.

    Simon
