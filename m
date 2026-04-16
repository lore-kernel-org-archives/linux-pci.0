Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C038AC76
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354109; cv=pass; b=lrZO7geh8DYHe86SXiymV5eOVuNNUfTuT4jgwD2292RvB4GAuKgcuRyYgCSDJnALtoGOhHrWoyysf9N2KX1vPy72wFxbZL7GJJt9t99zQMwT9oYJTdtbOWNs73KDAYoe0g+xvDfiBdOCN7IQytOMDWQxdYPKlHQpAFxNMIZnMBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354109; c=relaxed/simple;
	bh=zBGBrZMTwKJ68rCLDRs8azQlORU5x7myV+tVHdcijts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rt5RpzcYnWTiiimw4przfvUwtOe64oDQ13QL6PtbsiNSRlzfZOxh+zvy05coYiCe162Vz1l1jO8w9CEXxxaiSTqV5335Nr41cU1MvzYWGT7smfDGOy8NkO+Drg+xIAiSCPimxtULHnrgxwutrISFJ/o67yTQegRyUMnObtlPtqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5k8RptB; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5k8RptB"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64d5a7926cfso7811176d50.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 08:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776354107; cv=none;
        d=google.com; s=arc-20240605;
        b=fbe275OICg+o/uHfiFbqDGQq5LgyoLh2fke2PxPE6CXSpnmqIyA+9451AUwzk/rugy
         y1y7djI47jhNxKawambfktTUfB9FD9JP1zHnkqvk0o15njmplZBb+DYObBTodaFl9fOl
         e55PWOZWs7mL7WxA+45t6y1OpaGmaZ4IMx6YU4/7mwnw5Y+tqCzMNLO7WKmOLB1wDflB
         2eJl6Tedpq7Rm179XW+1xubNLQzpVfKwC0+bg3jQomB4uF78VAwg3yUmy1//GRCrRJxn
         YI6mlMHPXOeiDUb/crVCnyKFwEELD2+qngsZ5E/q1a/jSCfvBE4NBF3j5VJmsp9TTyxY
         s4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OCnOF4+nugCQPZVKQw/7phANXrJTt1mtYs1TJKi/ahA=;
        fh=4KK2MYDtvIbWafzKYa2NWNg5eHRbAhY71j1d3vUChUs=;
        b=LffHTT8ASasxkBh4y+7DzppTVI4J882ax78RhJ2RY/o7fCLxpxn1CI2GWMSTUrIHM5
         uTrAJiYyLQOHgyq0IGIW1rn0X+UI2H0xsdGiZ99cQ0lyAGDzsTYRydH2LAsDg+rEbsz4
         3Rdtpl1OsC4zF/YpmDpTLCAZwzGQdzsNykT7/TZ/4S18WZ6I8JroekLY7jLCmWYogVk4
         4KnzyBmPOk6jeI+Om9Fo/q7Mni/MFgI4MglQd1qfPkTNDg6XW1pLMRpOvwO2pPSmvNqv
         TXPlXwz4TbIzh2TA34uIwOeRe54FsecS/WH4HnyCBqaPInODPymeGNjaEQeHkSPjkl4W
         PA8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354107; x=1776958907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCnOF4+nugCQPZVKQw/7phANXrJTt1mtYs1TJKi/ahA=;
        b=M5k8RptBKBQylc39mD81QB/Ke4Y2T/5tjiqNXhpXkt0/dgWorzOuzLv6/itt+uoQzw
         npwfwrOHsUzOkhTqp8KCP6oYr7LFjXTrUNzZNPgl2RUKmcjcs+ZxiewM4tzY4U/4qgLz
         4L0wcCgYfKman6YI7/ynhgitzbc4oGWksbSKKt9aVdXGxkn7vjFyBpUNV9/Q+EUSNy5m
         XQ2qP8gWGH5Z85ixnlxrDaJc6VgC5zgOPMC1ybJwUBtiN2Ic2GMkJkyRW5XyMaR8YjPw
         H0MgDNkBqNsOaVKRNVkSSa/dZVSCmYmJ+rraev6g3BKgVrU2UgiiXULh/IvQDGNxNFBC
         7mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354107; x=1776958907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCnOF4+nugCQPZVKQw/7phANXrJTt1mtYs1TJKi/ahA=;
        b=r416l2G0YWiWnr/z2I0OmoE/xCtRIOUM/oPzMIrQ8Jfr2xllMHu7g5zQQHcbcHq4Xw
         2iHEmI6FRuVx/yepTRdbJxE5aYie39HufwoTEss6mqjtEVcurQEj+7SXf82f0TIuwtVe
         2S2bR4Sah+wfDwPfndWZ9i519vnT4gr8PfSejFOszjWt3fosYqkaH22SVnqqqA1vJq/i
         /TXpE1TPmLr+MgS7PnfTPxoPbeg9YG3VFG3FsiCtJLfww01pCkWJAepx9MdasrKEE21S
         C8gga87OZQc9J0DD3NY8MTGO3HBdriAcl8jV4TYg/nmlQxJk9HMlPx6kK0UcSSdVuwkL
         jxCA==
X-Forwarded-Encrypted: i=1; AFNElJ8HJJQYpWDwTjO1rAXCE5nPt0QRSSdl+RuDnAUjsjFoNlVLqkofwm9Fz8XmF6i30sjoy0oJI2PFLac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHZRixXbCZsiCRONgodMdXDOs9YjqnL+9qPltZzgCTvr/uy2W
	6jINB39AWAsUTEKKnwwJi77Ltg/PqNa0WbSZRa37rYLM6XsM3RqjGfPykrmCR+WJO8AzKRZjrYb
	M3xtpWpkDoX6jEEhxUu3UBScu6lgyxZY=
X-Gm-Gg: AeBDietLRg7ux1JZ5Gzxy56RpmWnjOsTBne1Tr3t8qMYJgjFhJtnsFAuKi7MW2P42w6
	Hsx9/9mQDaTiS77j1+Ljs/5qY3nNWc10469rkpFVUkwjaZpOu90J2YzdKx/rCWh+oCmUKsx2ifB
	A9qjz0+5gxNzPBEBFABSGUiSFdGkBL+0DXjgAza+BTjSDMgKe54mi1YnwLieljTODB0ZAM9M/wz
	WTvxHlREshj7V1eDJhzx+/vb+QaEnTk11au7Yw2s6JNVfQYxeNJSdOg7pDIcTMBOSdw7tCVW7Rm
	neIlaZ9deM4KvE1fof5HHYT4uWwuIHRJtlJcbQGoKuhkpO4mB3xL4U5m3PPJYVTF8JOc56QOkhB
	yc2jf
X-Received: by 2002:a53:bc05:0:b0:650:814:8124 with SMTP id
 956f58d0204a3-65198a88374mr18632177d50.17.1776354107448; Thu, 16 Apr 2026
 08:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Apr 2026 11:41:36 -0400
X-Gm-Features: AQROBzBjZjfRaING-KzrTi6Vvj06l3R7e7yZ4kftBDRWWzyE4CVrpze4YP2lhJE
Message-ID: <CABBYNZK7PghZH_hbeftOK0JptRv3-NOatWQ35kKSfYku_RB1cA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Fix build error when
 CONFIG_ACPI is disabled
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandrashekar,

On Thu, Apr 16, 2026 at 11:39=E2=80=AFAM Chandrashekar Devegowda
<chandrashekar.devegowda@intel.com> wrote:
>
> btintel_pcie_acpi_reset_method() uses ACPI APIs such as
> acpi_evaluate_object() and acpi_has_method() which are not available
> when CONFIG_ACPI is disabled, causing build errors on architectures
> that lack ACPI support.
>
> Guard btintel_pcie_acpi_reset_method() and btintel_pcie_perform_pldr()
> with IS_ENABLED(CONFIG_ACPI). Since PLDR relies entirely on ACPI reset
> methods, skip the entire PLDR flow when ACPI is not enabled instead of
> unnecessarily unbinding and reprobing WiFi with no actual reset.
>
> Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level rese=
t")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> ---
> v1 -> v2:
>   - Guard btintel_pcie_perform_pldr() along with
>     btintel_pcie_acpi_reset_method() under IS_ENABLED(CONFIG_ACPI)
>     instead of providing a separate stub for the ACPI method, since
>     PLDR is meaningless without ACPI support (Paul).
>   - Tested with CONFIG_ACPI=3Dy, CONFIG_ACPI disabled, and 0day CI
>     alpha config.
>
>  drivers/bluetooth/btintel_pcie.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 076beb45c410..07223965388a 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2280,6 +2280,7 @@ static void btintel_pcie_inc_recovery_count(struct =
pci_dev *pdev,
>  static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
>  static void btintel_pcie_reset(struct hci_dev *hdev);
>
> +#if IS_ENABLED(CONFIG_ACPI)
>  static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
)
>  {
>         union acpi_object *obj, argv4;
> @@ -2389,6 +2390,12 @@ static void btintel_pcie_perform_pldr(struct btint=
el_pcie_data *data)
>                         BT_ERR("BT reprobe failed for BDF:%s", pci_name(p=
dev));
>         }
>  }
> +#else
> +static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
> +{
> +       bt_dev_warn(data->hdev, "PLDR not supported, ACPI is disabled");
> +}
> +#endif
>
>  static void btintel_pcie_reset_work(struct work_struct *wk)
>  {
> --
> 2.43.0

Doesn't making btintel_pci depend only on ACPI resolve all of this? Or
do we really need to support systems without ACPI?

--=20
Luiz Augusto von Dentz
