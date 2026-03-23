Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772D3A169D
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269095; cv=none; b=Re83eQmbpl5mHKIZoRnHgRVf0lwcAcZgItXENEtjjreIvca41ZVLYK/gMRbK0tsNz+cDdyNsNJyzMuKsETEonLMtwBXjALegihBwv5POv15l/YYt1wGig8aHoHFi2jZUTQ5/nLe07LDJCB9vXxdxn0DT8813jksi8RchYFXFZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269095; c=relaxed/simple;
	bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=uFzf8T5DinAIYdxyG96JMlRvlaCsyLkRbHXnng8aSvvIeJzLRuy+QHyLaSybuVkeFX3D0uHWzPnDm0W5B5PTclgHCdtq9c2dNwrHrExqIR+5+n1mJKU9gsLua1IahZ0w/f38tS18zN0fpJsuX2fXTplyg745m8EWkpFYGUOk6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM/i673w; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM/i673w"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a27a90a7b6so65741e87.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269088; x=1774873888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
        b=PM/i673wZXZ47wS1CGpjC2G8sC1XiH1kd62IqDiKkg/0Tt5yCpVMRFYx5h8PHG8cfV
         20GHIW3OIUG6ISaY0jzjkJRw5KNdIckM2QpHyQ98YKt5CcpFIPBQx27pKBHIVUfxV6Wu
         Rj0yr0oJjwD7G2O1PhWVM5v1vyCfwrk7PeSxrimwz0Ss58q6mpljojLJJMSx4OrMXNFf
         ezIAiZ/goYAsgoUqJfNppXzRjdlpiJn0q0JIAFwiNGfdu9VWB2OsLHln3EMsEBqmRqV8
         EgbzFEUr4KTqOl7q+ck99yrDBcrRBtsdEdTMQBx1C0NOKzrgRq9hmRrzj/VdunRHAIYR
         tOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269088; x=1774873888;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzgvBHeJl/wREXK0TQEezXu9OIH34Ve9Q7AHGx5+z+I=;
        b=JVPkK6OyGjturOGypsI0Bb8u0Ns2cO2XmSWGCY/Oexr2+c1HILB/nV4coK7lVKNoC+
         rm5y9ELD4bwOWc250fgrAz+GQk0pNuOlzNi03sQtG98bkYEI/Hi983bS9l8n3VYxlBb1
         km09DwGQSGIyA4yyzhUajZ/iMH+7kOXXueRI9bDpjdbQfE2LXEkhzzgwCTr1H6CH/ucM
         dBsMPvMa4VFwmO2KvbgindasGWMI3f1lUNRF4Ho4Zx/Z/8CUrnYKy/09hQe0ACWt31BH
         N+ZNG7ZJqmpuN8crMRp329jSNl7wBQMSYnDWZaYkM34DI2MgVBOTNkkgpWXIqHMPkLI6
         LEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNFgTADdACBld5/523wIIgNiRt+wo1S0SLYemi3q+mA0unu+IlzSFVmRV9x2OgyVIWD4T+SWB/ack=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmFk3PhHZDKl8sGZ2NB99/lQSJL8rrNPoJ7FFaCExgXLo6nv7
	mWfEIIht7315GMBBoEiilr4NLEWPYPmveOt2gY0Go9Rb8lmBR5itAwo=
X-Gm-Gg: ATEYQzyEAvTeqsl5RtWfcYq8ZxboJ4jjV/FcaOZo1lmzpeDjghJC6qbxVONPj3tjkDX
	B1shWBLUYypLW8hnLf3clh3oRUig3SiTCOwL19UIxGJoFGv8+5b3cZZAvazyuAeEkohs+1KwEQ3
	O+bSUGQExMAuCyriIMiR7v6dQXfvVAqSNPXf/k8jABfKxqDjzUuq/pM5h2h3DuK97+tSH+GX+39
	pp6tWsoSGg4oOYD6HmOsasYaKzWOA2I2bu2NVURY55yqqYv/j8tx1oKEyWSqxz37OyBHXS4pmtu
	vgwe/P2obfaGnyParLqK+Wtrn4yIFi3GFF+I58LBZDLQoFvP0wM6rgSM3axOD2NXA0M7EFp9rd+
	6dCibPDzIdd2Jg9yYo0RvaHrxO9OIXRvOWoCk5Vf/Ss1r6p5l93/HKM1zMjDF978omS68FHVjhg
	arx8FH5wFAAY4KjrHKE1adu67IeZn3nAwklCQNcBcTvzIPm+59ABYQihB6tmO56GRdXswq95Cfa
	nF6VVScecHwY1uLRs4f9vzQk4cP3gL+MtX9UW0YqLu1
X-Received: by 2002:a05:6512:acf:b0:5a2:799b:4055 with SMTP id 2adb3069b0e04-5a285b92854mr3712410e87.39.1774269088110;
        Mon, 23 Mar 2026 05:31:28 -0700 (PDT)
Received: from bf-laptop.int.bjornfor.name ([84.215.3.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530cb91sm2582086e87.77.2026.03.23.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:31:27 -0700 (PDT)
Message-ID: <457c6760c569134a637d43d38e86d405963487d9.camel@gmail.com>
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU
 for OF platforms"
From: bjorn.forsman@gmail.com
To: john@kernel.doghat.io
Cc: bhelgaas@google.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-pci@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com, 
	stable@vger.kernel.org
Date: Mon, 23 Mar 2026 13:31:25 +0100
In-Reply-To: <20260320172335.29778-1-john@kernel.doghat.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Thanks for submitting this fix/revert -- I spent a lot of time today
figuring out why my VM didn't start anymore, and finally came here.

Seeing that it's been a few days since this was posted, I figured I'd
add this message as a "ping" to the committers, in hopes of getting
this merged soon. (This regression is hitting end users now.)

Best regards,
Bj=C3=B8rn Forsman
