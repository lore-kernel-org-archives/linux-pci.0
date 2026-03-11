Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D92F5487
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271416; cv=none; b=gjWgxpt/zfcDeY70AwIqxtB+HH32sr7LgBPDkkELVP3rbB93bNx7Ev40TNL4ARoFl4TmNgYmKrjKjB5hPH0yU8TA/x3SNmqlYUv6IUq10iMCQbdHqp3dtFUpPl3fFQA9cQc121F2r5TjQG40PyxewpGx936mDK14Ep+iIVq4/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271416; c=relaxed/simple;
	bh=bdGB8WswHXbQV+Uoyof7xfIRyZH3e+n+HJMxiIuDgNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6EqeBxaU4qsUiRTiChOB+AMr3VciNtAgT9dr0WCNuSlEuS0hyoUPFhUQ5gpO/oM96DWPXWa0mrzb9O3SFktApcvcdeLY9GNHPPcdm0rz+/IKxUWkoqFzRXwxMdimrqzlDc3tkdUZkTdcD9ZCkUt1voIQAoEzYV610LROeOcmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 095093F535;
	Thu, 12 Mar 2026 00:23:30 +0100 (CET)
Message-ID: <c8edd2ac-5841-4bee-9d06-500c1fdbb3e5@hogyros.de>
Date: Thu, 12 Mar 2026 08:23:27 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] pci: mark pci_set_vga_state() as __must_check
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260310193607.GA774938@bhelgaas>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260310193607.GA774938@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/11/26 4:36 AM, Bjorn Helgaas wrote:

>> The only caller so far is __vga_tryget() in vgaarb.

> Is there any reason for pci_set_vga_state() to be in pci.c while the
> only caller is in vgaarb.c?  If not, we could move it there, make it
> static, and drop it from include/linux/pci.h.

I have no strong feelings one way or the other. I believe that is

https://lore.kernel.org/linux-pci/20260220194943.3541702-1-bhelgaas@google.com/

Whichever goes first means the other needs to be rebased. Not a problem, 
unless backports are involved.

    Simon

