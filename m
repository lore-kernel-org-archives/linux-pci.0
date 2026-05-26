Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BC3FE661
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804534; cv=none; b=ACT2jPmSJe4QB5Auz1JpcfXgxezZ+eIdu+H4H+jfika4pKNSCX3wa56GkAZEf+eqc5FsQUZsd495T2sBqDINjVDFLGlemWAeVuThMxVFBs8dVgs022qqfJ8sfokHqHDm/4U7hnQtsGbgI9WZ8K4VIOjoDS5Q4KrkPDZkqP0vygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804534; c=relaxed/simple;
	bh=dH3JZ4NhnR8PRH+7+MukuBZQTuL/8dRo2g4wq/nlmII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tV5qhzHFKMThHzvRcZVsF6BwFnAyjG1QWEPGrK+t2y0tKhvePfgz9OR3tVMIPvfBQlXRz4MgngGNJjX07MKRvK6UHSNPBTfLCFsdBve5yNDP10SfG732p11USlUiMDLCfe62Z8s8+OfdVFSURCGTRt49YbGAqdlmY+pyZjIWtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etjqTwxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etjqTwxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66D51F00ADE
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804532;
	bh=kNmSyOMUmq8kdVCwSOpvJrPDDLfTCpPXbBcHN8085q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=etjqTwxCsjQ2JXeopbA6dSCS3MUGbDpfzEaop4zWusoXeN4VLZN7UwbpHtlR0vkqU
	 xmgN1lTnDUnufDsoRMNuaL5PHLkJ77g0wVPTOxjr3QhtQFFjy5+QDrpkVGsFEXJE2A
	 Av8gd7Q5KN0R0nLfxGQcFWudLK/rCY971RwXi/J6PBYJSHFPDd3utTTlq79BMolSEu
	 udr7OjvVNbGjtKBm80v7jUV5nZ1+yT1tZDSMrqzMwaYao0KK+QEdYLzlPYXlOzjdKa
	 4OfVtbOOJ/bWp6mPlWoCnZYr9cozhQExm5Wxo8W3aJmpNcMQunc4dkLyQydOAe5oEh
	 XxdL3ubY5qVKw==
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-575602688deso3766227e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 07:08:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Ziwsrq52ZTSErIcEfBiw9fxAg+EFg2U6zAKfYO9vshfntx06ohxG/8eSXwCGAGe+L8f7euUUU2IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHZUvMMJxUdGh6ns5NSjgUxN4JI51n8WrUX18evP01WJwn2FR
	jyJAEvyY7Xt8xQ3Ze42JHrvkm4ibe0Sha3ioSKcZwnutKq/9iO4w6bAHEtc3ZTUFaUptbqyrftQ
	iYJjE2uADQiEfNgCP1N70tr3LQHC/tc4=
X-Received: by 2002:a05:6122:4f94:b0:575:a6f4:46b4 with SMTP id
 71dfb90a1353d-586628c2881mr9984731e0c.9.1779804531899; Tue, 26 May 2026
 07:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427205024.254677-1-superm1@kernel.org> <20260427205024.254677-6-superm1@kernel.org>
In-Reply-To: <20260427205024.254677-6-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 16:08:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrf=EVi-HgYMi2S_fQHb6jASXXQWU2-H7DhacbWHn5LA@mail.gmail.com>
X-Gm-Features: AVHnY4J8W7uEFlrMnFBXfhh97lHucVo6vFvEx0JJwp1-aRdc1DSeLj6b2tpEDvQ
Message-ID: <CAJZ5v0hrf=EVi-HgYMi2S_fQHb6jASXXQWU2-H7DhacbWHn5LA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Devices with no subordinate should be put into D3 during hibernate, but
> devices that have bridge_d3 set should also be put to sleep during
> hibernate.

Why should they?

> Adjust the check in pci_pm_poweroff_noirq() to use
> pci_power_manageable() to cover those as well.

Please say what actual problem is addressed by this change.

> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 793af4af2971b..3c82d818ee15b 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1254,7 +1254,7 @@ static int pci_pm_poweroff_noirq(struct device *dev=
)
>                         return error;
>         }
>
> -       if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> +       if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
>                 pci_prepare_to_sleep(pci_dev);
>
>         /*
> --
> 2.53.0
>
