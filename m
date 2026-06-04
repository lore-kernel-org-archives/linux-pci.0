Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7441C313
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574959; cv=pass; b=N+zGWdsxtDSl7c/6B7aXXpLCDvlDiujFSpKMCx8VLkHJU/a7PNHWnA9LhRP0Qe3TqehbrNBzEIONVRAaXNIi5qUarE7KDAgLVwS1+ayQe2NhRKZD5xfujpWoOcfBzxK3T5ZpRZZXtoCHzeXeCmsBaP75Z8NTsYvKPGGECAAEBjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574959; c=relaxed/simple;
	bh=uj4K88qc6lPcbN3Yc1wC9i/Igrgsbe/5UqnLXF7tFxw=;
	h=In-Reply-To:MIME-Version:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssNlW/PsWYVItk78L/nYWakr/HHm8og3vvS2RTydKkMBpNMtc2eZ2ivRCKDoPLe3+kh9E1lpjy8zmLL92PLoiErsaUap4v/Jt2vp92S5NRXDFSdE6DYPJMG8HNfxqIGRZEnYOHC7KLV2FDJVAyUdtgCusOTQOdhI5F94IofpcpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS+26SIH; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS+26SIH"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66077c46c5cso621008d50.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 05:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780574957; cv=none;
        d=google.com; s=arc-20240605;
        b=jXaqJ+eO33kkdQhsM5aSmp1j96ntwPV0vWARtyFL2BboHWt3lOS0GyZ5F2BsFjaMpU
         5ZXDky9QpzDvgexmrnJVD19BG2JGG5dDVSTPNqRX//ewjkiDWfokx/eJb1A0TxsWgdi/
         5btIRfrAMxNXL2F13Lw+xeR6tpsJnGbCACT67OHSRk2bz8NbR3AGHIjWWSsQlqoSWFhf
         lOZUEvrtg9H8hw68UZRnFqn9v+AeCTKZ8AU4RyIJZiU34jR4vDsKs7PWx9ifLTYKiNnT
         4EL4IwptuuTJJZ+vHlxhVeCeb5OJE8OY6kmvkChLutAiHlfMd9xglohOVc2neXWwW/hJ
         ZDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:dkim-signature;
        bh=6ifSH017/6XeBpJ1mk56x+Yz6Ui1nA/vUxvuucn89y4=;
        fh=fTIjtyMIGgQDMc1ldHuy/W04FP7zMdnKxhVp2RML5xk=;
        b=NaNhBx0CR2xb6IWH+0GNYYpnYaQI1mXLDZiHh2bA0DeFXM9pjB1PNmeHgunPN1MmMk
         rBnr9f3utaVpx5KaIQxIoxOAZis3uIeGb923oVQpBk6pacDIbvNQlT3l3hPT88eaUAjr
         hKZGIfEAliBZlUbVQZEdHlD9jt/7K08PyS1JxM1oeEqVlqkonhqJ31SwJk/jjjZ9pdFY
         QwpcZO5QBco5f0rQx4lytPqBjPCvyIGXQPJ5CavLijVCG68pT24RfJmLJJBiLbun3NgE
         +qdva8szcFtluDjLUCzLyPVmj6lmq/lOuFxkKWvI3mZ4DF5EionbysgzhAorOn8PXfsj
         NOtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780574957; x=1781179757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6ifSH017/6XeBpJ1mk56x+Yz6Ui1nA/vUxvuucn89y4=;
        b=SS+26SIHrEnTCl1BZkXHSOrEkPe4W0Ol5RQudc9dU/rC3sx+nLUfIQyocnJxTVlYf+
         sqkts8xWA4OUjbDG5cQkV91E5D+LR1LiWPKRPpxmcIh0+JWbfc75VKTSx8vKmBXl5tcm
         CfmGDjn7QCVz+dY5GdeTuqG19N2PUICfF7eygp4iKviHEsVoqqQH5ktTjuHBhKv6LWZF
         HxhgTUajRR0IK4r26UZC2qvgw4SUHpEgWQfBgNpE5z3+WbZ0ongby2Ye2XEX39DeFepF
         PVdbNGZaAW4Cd1tQ+2SeHWgK/OToxe+7uW2XfYKLITM7D7xF2S4VulEbta/hFY9hWkXN
         75ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574957; x=1781179757;
        h=cc:to:subject:message-id:date:from:references:mime-version
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ifSH017/6XeBpJ1mk56x+Yz6Ui1nA/vUxvuucn89y4=;
        b=T4Ys2lXMIwEvGeRZZuWfyPMIcHGqjW/OY0KdYJpXGkT56jJQoWdqW7j3AksNUWEPre
         5a70iQ8/vyDnuavfJb27yELflxoWk33O/DPPsKLM6jnYjkTIDmLNjt4OAkXk3XqR3mjI
         7vCWvgxRfFohCt49WFc1IHDJFJEsMXvOqwcq+N03zsmQWqL+W0y52vFMmgQwN/RQ0HbD
         23Nrj3UXcRJUHIji7Uo7pv9mwf7yNFSAJuPQQceOsE2AQI8UOMNlugbg5TuwAVy7H989
         rFaODWdLoh3vvBTFAtZYQJYRU1YcaNeDSBom57Rtom8Af9wU9VEzi22QV2PenvXA9uQ5
         W/Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+mghqk3pw2CFGVDae2WMbm6msWy5fn5lrA7/xcR/4ImV6djkAf07jpOHEdmyvf1M7LRFNUiROTndw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWWEClXzCGL91EIk5BAF1yfjU8uwUU9xTPFOKIjmSf12xYVLt
	n2b+/SJN2YL//9wYNaG2isebxLWOWBJwqNybdV8AhB37TfuJd4nuKlqDWNiYtnImTwiYyFUO+RU
	AKeU9XjsWdEmif296L/b5jCZ7ogt+N2c=
X-Gm-Gg: Acq92OERzlmVTJ4GvQs0DceSMnQH3Gl/pc0lGLk8ZF9zfHML5x16pJyZO5zQpSE+KGp
	uIHUReebwWn3jZICWWvF201QgPO2A2zdFhORPG/d3tDGG+sfYA7tvXEHn9ueffYiILditAGWoiq
	QC5tgMNLHdxFm56JQ/qA0O6ZbK+k1i18zeWMe1cclqUj8xItfiEOsnE+hBua7PmkICgJX28AUe5
	ys7DVlCZNelvWuZvX/PtNwDAOs9bHOnZ5e2run+rDrXfkN3e671k/kzGjcLQGeeo9CUuNjSZTDf
	Lpw/ocK+B2UV5GuLgu0=
X-Received: by 2002:a53:edc1:0:b0:65e:b223:c15 with SMTP id
 956f58d0204a3-660dc561bf3mr5574275d50.49.1780574957417; Thu, 04 Jun 2026
 05:09:17 -0700 (PDT)
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 08:09:16 -0400
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 08:09:16 -0400
In-Reply-To: <76bb3e5b-e4fa-400c-b7fb-98f95c7a068a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260530-mutant-gecko-of-anger-ce8803@quoll> <76bb3e5b-e4fa-400c-b7fb-98f95c7a068a@oss.qualcomm.com>
From: Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>
Date: Thu, 4 Jun 2026 08:09:16 -0400
X-Gm-Features: AVHnY4IchoeFwiwuUzc7MAm7ADNP4K3glOC3B0Du3JAMkFblKsf5YvA0cBqg6dg
Message-ID: <CAGyK6coCyziKzffGmj+fGs4U+mXEeYJ0Q2+z6xHCA+i=gop2oA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
To: Matthew Leung <matthew.leung@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 01:26:53 +0200, Matthew Leung
<matthew.leung@oss.qualcomm.com> said:
>
>
> On 5/30/2026 3:06 AM, Krzysztof Kozlowski wrote:
>> On Fri, May 29, 2026 at 01:10:07AM +0000, Matthew Leung wrote:
>>> This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
>>> platform features two PCIe controllers: one capable of Gen3 x2 operation
>>> and one capable of Gen4 x1 operation. The first patch adds the device
>>> tree bindings documentation for the Hawi PCIe controller, and the second
>>> patch adds driver support by enabling the Hawi compatible string in the
>>> existing qcom PCIe driver.
>>>
>>> This series depends on the following series queued on linux-next:
>>> - [PATCH v3 0/7] clk: qcom: Add initial clock controllers for the
>>>   upcoming Hawi SoC (Change-ID: 20260316-clk-hawi-1ad4cad36d6a:v3)
>>> - [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
>>>   (Change-ID: 20260311-icc-hawi-d6dc165f8935:v4)
>>
>> It cannot depend there it makes it unmergeable and untestable. I skip
>> review in such case, please follow standard documented practices about
>> decoupling independent works.
>
> Thanks for the feedback. On checking the dependencies, the changes are
> applied in their respective maintainer trees:
> - clk: applied to qcom/linux.git for-next, commit d6cd9d5692ba
> - icc: applied to djakov/icc.git icc-next, commit 07548b04dc36
>
> Both commits are present in my linux-next base-commit and have checked
> dt_binding_check passes cleanly.
>
> I can resend with the dependency references updated accordingly.
>

No. It will still break the pci tree when this series gets merged. Please
resubmit after v7.2-rc1.

- Mani
