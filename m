Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF46263C8C
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055691; cv=pass; b=YyhEegJE+6qEaJqyMvzvEuR4hum9Y9xEZriD7Ov2YZ7KspPIWGiclrOmFuXGFqFSkQ8jZwRWe4ipGCK7EWKo2gT4OgW3RGdQf4lxMAfD90laV+kvgIrcV7vC8CtLdmXXvLR0qFgmoiN4xtO5Rf8f+oItAGgXczb4XtwZ0h8phUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055691; c=relaxed/simple;
	bh=F8nmJNYA2lQjU4+qs8oOjHrg0i1hA4xuDHcHJv4bmlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CspixsbNNKRT0cmBeSAEWZNovYVGpiUZd7XhKjXI2qQvhYZ8EUlWczt5TYwzB3W5VtHGnFHJIWoWjK+d7uH2FVh9GPIAI1IYaOG5vaz3fMEuWL+mxPAnvgPtzG7M8uslgLLw/xqPpsPyvF1aQKdlUYzzduCFduC/to/0dLKdPxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX1DRO9t; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX1DRO9t"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso26563a12.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 10:08:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770055688; cv=none;
        d=google.com; s=arc-20240605;
        b=EK6lk9W/6QIrhEh4CDbRSm7OteXfAJVfoUMfH53zFKId2Ph04QQPtlLF69ogy/vrpT
         8MOin4+JYQeswhCsFs7zpNNgNhf8HQSb+qxmlGXr+h8fm48sij0ECBQvsslfmeO5QzZv
         NvrIP9PYTbOFFRLTQQa6NDW0zfus3N/DmnQqpBo6wnFazMoqcTUFNCoIpHhTCjl20sCH
         zNiciD0qJyiEkyg2sB/+E/WsS3pcb4oQ1C8hyStABtYp9xzqRSSt7hMiDiy+1SfKPByA
         HQ49jBHcs/eI2MRpyy6m3w1VQf06yfNULaSLFNTuhINM0bArS5odyUDQXbKrvDmLtf68
         bxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F8nmJNYA2lQjU4+qs8oOjHrg0i1hA4xuDHcHJv4bmlI=;
        fh=1Xatij1vNMb6KEL+05QAOpipHoWu2FH+p9OgAc9YE68=;
        b=XrCXRs3EXrcykfoe7BYXVFHD/q5FprU6pyRpkuXBsbVKpaIdXqbRlV6646gtTwEils
         +WMDNwSLB0drKG3scsNbzfDwvm/Ybn3A1ycP4pUWSyRkbvZ767xV/MZ2WAXtITfCVqx3
         nPlWS7vAu2zY8BW0AJ9eBodP1UZxco3Vvoc2/WXipNWKpG9WScTeisM8NfY+IzWV2RMP
         /k68CWwsgjE0TMntj8wzLUDTtMwEZS/Ep6oXc4W9H7pO/xl8AnVPVh9fuj9iXfnkYnhx
         tel7S1vkq1jbZCmDkFkqpmsfPDALjn1gZroDXI+S3hHkZLypzUcTnmbYi4MxUXXp1C+Q
         nZNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770055688; x=1770660488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8nmJNYA2lQjU4+qs8oOjHrg0i1hA4xuDHcHJv4bmlI=;
        b=YX1DRO9tXMUGpFIsgtnknY+k7Oo0UGoq5IQJUH4zIAbN4os7beSguMIVJZhHKZBTC2
         5PiteEy660jk3q/mj/2i1ujsRlTjbc8U/ixsDKB6QpLo70ivnd/SVPombQ67WV1eqBdm
         aaUHLdfL4mg3mj5nXPOBz1qS6V0CNQx34Bh23ADiqAiZacS0nbDX9DZoIqMJlczjh9dk
         PFH9wEmso9VVFHq7gh02BIxTeebLQP71kixnaKuhYXP9WbC0ViJZ56I+V522sDWZ5R4e
         teIXWLRZ3Zb3sK4cDZGPJo5woqe+r/H3Mc7s+gV4KrwVjtrn9E4zSH1CO5HS3DWHTogt
         WhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055688; x=1770660488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8nmJNYA2lQjU4+qs8oOjHrg0i1hA4xuDHcHJv4bmlI=;
        b=G5jhTMq400HR8QdiGEK2L9EnkTan1PFLxt8j7ZtK0HXEUFOuAgcp1BnmDtMx5hiWih
         yFlksehWDyHQezDrAEhVH22sXsJlIX3AXu3FNamJxRRfG2tlGGKmPdH7uNHkOggOJfzG
         x0ghp4cWRB+ml2N6K1VoYVbJpp7NkKYIyPLryrDsyi+VmLiB31/VW2Gf6MnsZmYj0Dmb
         +oxKzKy4xg8PojS+VVGKKkj0hlWKBSehheYEtDQgHIJVlzURXL6WjjOegQJSsu27tSj3
         4Ym6vKxUZMJLcrm5yk6xRPknf6v0MDaVciWE8TZ2QHe4Y+b719crnKW8wgL3eHsBDzYY
         BJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1qmsxYt1biM5QrIWwKdlU1O2gXJfM3ijZzmNOfNXNqZfRMg8K5GZ+z4zAONIf4+gGXWErRy8kLJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIm+wCS9uI4bootifHK+ksK+lsTcUF/Kg7FpWbNBpwMfUm0fCN
	UZQppdAOaSPdc/W/S+iT0SwUNTNgVMOR+AP6+Ta6pbxgtIqZPkv4E5I5oMwAhBcH3lmGH4wjSGY
	w2nnTnQJaVtRdRzkWF+pvCONHj8NxU7Y=
X-Gm-Gg: AZuq6aJtz1GAfKDQiHrL0gAk/qBn2SKL0EgsOB8kQNzKQ22Ca4x+G8b8HKeNNNoH1b3
	qL2Ep9POHwYMB3mhJmneE5O5qwbMJoHbnvq8EQcV4JiD74RydUtzy7BcYYIwkRfdMrYtAjqcQ1/
	6NOdTWZbyx3gP/3FN5kiu0Z0umWP55THjY/I70H5g227HY3N2eVbbVpLw0e01VuyTX4gF8PGfCt
	fkBUTaUH7SvtLCpCjrr/4afulN6iu4a1jKs+14D9xEXe1gZuxT2IgBUI5FX0bAlDIU=
X-Received: by 2002:a05:6402:1a53:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-659327eb130mr152714a12.3.1770055687927; Mon, 02 Feb 2026
 10:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
 <aXyHITrZ89Mmn8_J@ryzen> <aYB2IVdh_kth1wtn@ryzen>
In-Reply-To: <aYB2IVdh_kth1wtn@ryzen>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 2 Feb 2026 23:37:50 +0530
X-Gm-Features: AZwV_QiGldhVnV5gsPLLz7K7IUZirLvxF_bXbz8XfJgEu77Yy7zS1U4IFVWDkH8
Message-ID: <CANAwSgQtWifFNFe-rK7s9VCPJ68A7LSP+va2zZWr8W+vgZOjYw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Niklas Cassel <cassel@kernel.org>
Cc: Grimmauld <grimmauld@grimmauld.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas

On Mon, 2 Feb 2026 at 15:32, Niklas Cassel <cassel@kernel.org> wrote:
>
> On Fri, Jan 30, 2026 at 11:25:37AM +0100, Niklas Cassel wrote:
> > Note that I've built the network PHY driver that phylib wants to load
> > (CONFIG_REALTEK_PHY=y) as built-in. As long as the PHY driver is built
> > as built-in, I don't think that the problem the modules code is warning
> > about can happen. (But I also don't understand why it is trying to load
> > a module when the driver is built as built-in in the first place...)
>
> FWIW, the reason why PHYLIB tries to load the module even though it is built
> as built-in (i.e. is already loaded) is explained by the following comment:
> https://github.com/torvalds/linux/blob/v6.19-rc8/drivers/net/phy/phy_device.c#L852-L855
>
Yes, I have gone through the history of changes.

>
> Kind regards,
> Niklas
Thanks
-Anand
