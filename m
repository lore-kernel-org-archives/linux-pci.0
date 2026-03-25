Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B727260D
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422091; cv=none; b=Dfi2KVmGBL6z5vz9H7USpQKKmCaIr8vin9UOLwVdxugfTgHtlCilLsMqJ2sw50Pu1CkRYUNkts32c4Ar1BWrNuFRGHppACz1zhDu3ic5dkupMefpJAqWWxNRE4kf22QHTcttUsxT+i1Xwb9rGv1B6k9/2yL4ezlDFLhMEtnY7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422091; c=relaxed/simple;
	bh=7LlkcxJ+xJJ4f8he5pL0HgypxHU/Ghcpkf36FNJ2ZiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJZOZ0W0AUsrtZNyGOg9OP7mrhWu9laYfT5u+UOdX0cAqu6lsU0Wa7qlEvGJlFPcD2yZpoW51yVCoro8pK46IYWpKwT5GOz15hLTSFPh3hTmDv7nSTy2IX7MuK933+b5T/iNuQ4FRdIMyzEUjl8/3D0sFAWBmKs2560yuEmdyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 2324D3F004;
	Wed, 25 Mar 2026 07:52:39 +0100 (CET)
Message-ID: <005254cb-6070-488d-a548-9ac10df568a9@hogyros.de>
Date: Wed, 25 Mar 2026 15:52:37 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vgaarb: pass vga_get_uninterruptible() errors to
 userspace
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260324193748.GA1149226@bhelgaas>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260324193748.GA1149226@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 3/25/26 4:37 AM, Bjorn Helgaas wrote:

>> If VGA routing cannot be established, vga_get_uninterruptible() returns an
>> error and does not increment the lock count. Pass the error on, and don't
>> call vga_put() when userspace closes the handle.

> I applied this, but I'm a little confused about the "don't call
> vga_put() when userspace closes the handle" part.  Does that happen in
> this patch and I'm just missing it?  This patch changes the "lock"
> case, and the only vga_put() call I see is in the "unlock" case.

By not locking, we're not incrementing uc->io_cnt and uc->mem_cnt, so 
the release will not call vga_put().

    Simon
