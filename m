Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5302329391
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326905; cv=none; b=ZLIdTeBKzakxKMArt9Ck2X4vuHku25jI+372iHovo8OVYFq3wIA4CI9I+jlkdt7VAQlZPXoTEI4vqOtPzxQV8F1Y14mEirJ83CYdWQe6CJ/TpUpU8hPUQIkPvfagU/szCyjoEB9ydny1ahe8FFuOEKJm++gp4YwGZH6y9lOUjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326905; c=relaxed/simple;
	bh=YiefSNL13ppBHBoFXG1yfRRKerN6jmuU68jlHrzIhII=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MId8oZbw2FQpGHfQBgD68WD1l28n9ublnuRnLIjgMVJMDDZSEYdy3QejK1NsFh5/bjQCJh/SjBas9BYM/diBkzqLNnyDfn0L7gEQIaOR0vcBe9KR+SH7P/Cag7sKTX4j+zc7TdX46J1jyatLpahTK2zH3GeL6J5T0Q4IlY6fsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ86Cmfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ86Cmfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA8DC2BCB1
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326905;
	bh=YiefSNL13ppBHBoFXG1yfRRKerN6jmuU68jlHrzIhII=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=qJ86CmfoQYy/gk4deNltdDRw6nqP2ZJYEHaaSG7DYPjRALZXyZm2Xr5JzhNOhDVrv
	 g+kJDYawG5dmJ30envvJU+ACEkVXN4nKi0NXFmXHWSopLa5E+MTrq2XsV5gkeEw4Ru
	 NdDxe7U2qUVP657DayTVw8sHdVLiquoGyUnKo2mCpfTE28dMofOIOhKDsDPdqnfuX4
	 IbTdd/AsjEPQlK5scXukkX1DF9YWDUxlLBE6TCnBSC9U4gnECL26qY1BxMdj0TYuW3
	 WqP8JGJBTciikWaFx2Hi+4q3O3sB23O+aBNeqqrsdRMW5WwuQHMpY15wwFyuwURiN5
	 u/EpM2eTm0atg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59f791a6e67so1252146e87.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:15:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLqyr+Yofxng5C9lXXU4Tj5X50zlsvhhPgU/8A936VZermCzciARMve77RfTkQIpNub7z0tMt4cHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOzT8/zD824P+0B+NxKrKLLIJA4YBSMjIlXjOSDmwFBdcuWPM
	wyGyBQiOL1nskORcWRcmnqkr+PoiiSVAOYlgLJDy6cqY1G7eBtFdO1pUh99peHMlOoSikOsQGiS
	o3V68LhUPzpmiRCrXV+upDMIdBQztI+7CLy3Y1zayFw==
X-Received: by 2002:a05:6512:1302:b0:59e:6f4:d224 with SMTP id
 2adb3069b0e04-59f6cff091emr3387835e87.26.1771326904205; Tue, 17 Feb 2026
 03:15:04 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 03:15:02 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 03:15:02 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-1-b5671e58934f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com> <20260217-pwrctrl-fixes-7-0-v1-1-b5671e58934f@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 03:15:02 -0800
X-Gmail-Original-Message-ID: <CAMRc=MdxUui9-Y6DP6ujeCUgLOhgUZeQ6qRCBdJDFQBB-EHFHg@mail.gmail.com>
X-Gm-Features: AaiRm53k6K-sj3qk9d0wCwf8b6XkLqKRcsUH6QFHhVavdzE4Y6b19oazs8dMRkI
Message-ID: <CAMRc=MdxUui9-Y6DP6ujeCUgLOhgUZeQ6qRCBdJDFQBB-EHFHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/pwrctrl: Ensure that the remote endpoint node
 parent has the supply requirement
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 11:18:46 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If OF graph is used in the PCI device node, pwrctrl core currently creates
> the pwrctrl device even if the remote endpoint doesn't have the power
> supply requirements. Since the device doesn't have any power supply
> requirements, there was no pwrctrl driver to probe, leading to PCI
> controller driver probe deferral as it waits for all pwrctrl drivers to
> probe before starting bus scan.
>
> This issue happens with Qcom ath12k devices with WSI interface attached to
> the Qcom IPQ platforms.
>
> Fix this issue by checking for the existence of at least one power supply
> property in the remote endpoint parent node. To consolidate all the checks,
> create a new helper pci_pwrctrl_is_required() and move all the checks
> there.
>
> Fixes: 9db826206f9b ("PCI/pwrctrl: Create pwrctrl device if graph port is found")
> Reported-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
