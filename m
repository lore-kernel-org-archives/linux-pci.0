Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26D388E4E
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946929; cv=none; b=kcNAiLmZTY+nOg/g7k6r0oI0LrQpRCIIR3df3SCBhq8ZmBEAibFpx8m0caTB3lvkF3hQnvDJ1yIP7o+9b1LcPi3zr+yv29IU+dgZEtsU6X4FdnQbLXIItjp4+3m9N0F8wtHudecj0e7JcOr8hte9REARU8mr6d/32mheOdnHdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946929; c=relaxed/simple;
	bh=Y2pSW1BeeeALOcK3SHNmAQVg4yi0DNPRpdDIbdNcTkU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=faK3NgOOmlnGJ1SXAHSwtNqaJczZjo4EtOdrKKcb0lbCM9nUC/CyY2Zk4hpROXYaGE8sXFWRjQkMu1iW7TaOJS2tojOz6J+DTJplWs/G6wQL77oi8sep7I7nyUWIO2nbwsXMdP3fG2/pLLKAPnhVY+pitr/9/oPRUGH8/H+YRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfZ0eal1; arc=none smtp.client-ip=74.125.231.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfZ0eal1"
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-6a38f11471cso89893eaf.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783946926; x=1784551726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2pSW1BeeeALOcK3SHNmAQVg4yi0DNPRpdDIbdNcTkU=;
        b=PfZ0eal1CSVBb9EbMjiS7Q/2Pyw/OuaNfc/bA03fMmTKLa11S4G0/FDcLNfprni4A0
         vdMmiTqDDp/vm/5Gy8lUwEQRwWOCJpAbneuxCQIv3wfZlS0iGTBqvz8pDCM8bvgmAxpB
         qWFq83UWZFWoTMS8IejgNaXg9x3NndXJnhlClXReRQ3JBRtMUl0nbWzLj2xxolb9yplG
         HZMYQBLK3sMpBKxTNcLdSsa5gxjNViRj45ng42tcBL+0W5JzTtf0pSObvTvWc9QEemS5
         1CDoo+uAzAR2cMn9c6xau2sY3chbJexnYhwduDxbUr61uXeCh9ACIvoaHy85l37leuBx
         Oh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783946926; x=1784551726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y2pSW1BeeeALOcK3SHNmAQVg4yi0DNPRpdDIbdNcTkU=;
        b=YZQLfoNWtB+63W15Wqo8ea6/8gx3qQyn3D90znuFs+8LZULCDJBd/JQOE6Jes5B7JW
         FFfER4D7D9fSnTl2sKWTSHVvJEj180XtzoQYmAGKo2omJYraEQnWnHZHSMACq0j7zoQi
         LJUvGRQieOirXgbyuXdn5xwX8yhOsq3ironauVvKPbLAyAqwp6AtDCd8neWmPShnBJ7d
         PEfo1HvbYnqKXFRSPIAL7zLfWiqEIiLg2wAQSTjaUexJOknAjp0qZ/EdKsUTjtQmL+Oj
         jdVx4D8yYUpcpZ9N0dam/O5Qj2Mqbu0M+eRX4wTm6DkEyqotDhr7uy5az+PtoSGbvVmJ
         LY8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/iiRS1aDMl1zSmnYR/bqQaIiLXNzlW4bCTbghdAlzFxuzBsbw5VaZIr7Sx7NHU8iBZmuB06VBwZG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtv3HsYIn1cvkAIW5One+TD2QED5zO+bC0yzGtXVB7wn29dBlb
	INg9JqqemmuTVU+A1/EufooRPEVzLEezRl7U6x2+fWQXmVj8EAABpwd/a/SSWuH4qf0=
X-Gm-Gg: AfdE7cmxP9LBtyLAWrKL2pw14mTYjKfzL1sL8WoaM6eWgGdkpFRFcvF2FiceWNCoLz8
	y4OEDwYs/5iVPqfXebB8NoqeNkqtw7bQ4ARiEN8i/71xi441h3t/XOK9ZAYRvj51X1TZybWG0YV
	rzFuXwCbJa9c6v5ws929Yqi5vV5KRh3kK8WGaVFmBPKF6Ocv3MiYJVPpT8cUXIlsudXjdo9+1Lg
	6ng+WmZlxRy+LohepPmjdy9HO0leN0vWvMg8OHvnwpMxpGAwgWHDBM28+++xot6QYkpm40UYFiW
	PK5KA3XdF/z0682KVmUU+QQTRB25UVl44Qfvc8Z7JSDMExybZ7ak4lWDbpB6eU0wsSj8oxldYpR
	vVE1oWhsh1Q6b4zE3wwXuIr5YbCu1ERdFdSHGXFJbVvCHE65moU2AJw3DZKHn5UK7tEnCVao/IY
	SCMKyjz+yJyl647GfZWJcFuoYl
X-Received: by 2002:a05:6820:4b8c:b0:6a1:55f8:6bcb with SMTP id 006d021491bc7-6a39a6ceee5mr5256977eaf.38.1783946926553;
        Mon, 13 Jul 2026 05:48:46 -0700 (PDT)
Received: from [192.168.101.143] ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a377bd9cb1sm9677041eaf.15.2026.07.13.05.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 05:48:46 -0700 (PDT)
Message-ID: <b72a8cc8-219a-46ab-8bf6-8a6d3e142429@gmail.com>
Date: Mon, 13 Jul 2026 17:48:38 +0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sashiko-bot@kernel.org
Cc: alitariq45892@gmail.com, linux-pci@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20260712180440.423421F000E9@smtp.kernel.org>
Subject: Re: [PATCH] PCI: starfive: Fix unchecked pm_runtime_get_sync() in
 probe
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <20260712180440.423421F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review. These are all pre-existing issues separate from
this patch, but worth fixing. I'll send a follow-up series addressing
each of them separately.
