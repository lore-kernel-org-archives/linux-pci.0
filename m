Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B533BED37
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932517; cv=none; b=gDFomOsrqLKRiHrxUMgTTNkVK+kfIFCmWX43aqfqYHcnyoz4Sx65ZMiNn2SFiSejTr4sXe2wldhrOReO2l/JKeZ4fNwjlHdXMtzGm0dAAbk4bfpS5uiKkjrHIaInqaImiqQwINSYBAdo7qI7+r3GSVnVkvMacq6ChqP1tOAQ+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932517; c=relaxed/simple;
	bh=fRPblbbwjt/HkZn1EoI5pPJ84BGUdl8hE7iW/86mfGE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgZhPf/7JkWvcmAYX5huTVaqktFagyKhzQa+YXCVBQboVegUMD0+slHMkltQehTEmeSGeLvDC3EKzIHA4nhz7OkjKhSxpLnPZeCsX2MzgHkt6i08bvyy0/zUZdbuSNd6gaMicstT0mgEDLwLOlb0H+2ZzVaJ7nxzUXakzclptlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz04aKBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz04aKBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C79C4AF09
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776932517;
	bh=fRPblbbwjt/HkZn1EoI5pPJ84BGUdl8hE7iW/86mfGE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=lz04aKBfg+8JqUzu1MNXdN6nJHx7swYtLHfliVAGAJu3+G1kxtkSX3h+OdiZseiL6
	 MHuyV8KVw+2DdjsyxxCbNwihviZLvQKi4MDoyEbf7Bjb+JAvgZXKslUd0KpbW7MKCC
	 Yj1fHMhw+/05/nAXLc4KqKS/xeHggwcplJshMffOrzMaqi7R/hL8DRQ6DBT+p4hAqL
	 qq12LWC+X5f4Kp6y16J75FEdSs0sgWsxfMqn+azreFeKr+QY68MfPQ7rpDKMFLry+a
	 bg+5ajtjgSO+FzLNbi8NS7y5sdgaSABZv8VzPjgIp/cuyAQAgHJa3a28ZKsvSyXrm/
	 LUREad7wKbAdw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a01c80c34so60716111fa.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 01:21:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTUh9PhnnyJHaoH/BQznTKmrMy7P+6mJoplOpaJoH281EW5Y7p
	gitGz+nFIldx5CubmmSFYhZWg7dXP9SlK+yQnnim0lSlCsUkt18EWFvkvSUS5hF5w+Iel0wQ9Q4
	7suDRA63G9/poS8Gv+KkMct54y1LTD/imSEG2sL62SA==
X-Received: by 2002:a05:6512:304d:b0:5a4:b02:66a2 with SMTP id
 2adb3069b0e04-5a4172e1bd6mr9210840e87.27.1776932515490; Thu, 23 Apr 2026
 01:21:55 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Apr 2026 04:21:54 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Apr 2026 04:21:54 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260421104102.12322-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421104102.12322-1-manivannan.sadhasivam@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 04:21:54 -0400
X-Gmail-Original-Message-ID: <CAMRc=McF=PAJ4SUFOSq79DZZmn+q9g+Av17=v02AZ8ZEddtnCQ@mail.gmail.com>
X-Gm-Features: AQROBzCs3iVr5IY89wcTf5UqOOil4-CalTt1Oy-nWj2iK6EtAc4zRvrm-BQi4W4
Message-ID: <CAMRc=McF=PAJ4SUFOSq79DZZmn+q9g+Av17=v02AZ8ZEddtnCQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not try to power on/off devices that
 don't need pwrctrl
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, brgl@kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 12:41:01 +0200, Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> said:
> pci_pwrctrl_is_required() is used to detect whether a device really
> needs the PCI pwrctrl support or not. It is currently used in
> pci_pwrctrl_create_device(), but not in pci_pwrctrl_power_{on/off}_device()
> APIs. This leads to pwrctrl core trying to power on/off the incompatible
> devices like USB hub downstream ports defined in DT.
>
> Hence, add this check to prevent pwrctrl core from poking at wrong
> devices. For this purpose, move the pci_pwrctrl_is_required() helper
> definition to the top.
>
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
