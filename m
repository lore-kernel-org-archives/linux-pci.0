Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139314EC73
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270825; cv=none; b=IG+BpRJAIck2jVmlMAmh6yN+KVeEK836hcKri62JtT/Od6R4qpOjohAZ59by7lh6Ephb05gMqWMJFlfgpstuBEWGWIh3i5qcz+Xs6AmATMb+YvwfrRucILcRYkqSX1ThJCgR5Nz/MZPVycqbebBrCIiX8CmU3ij0ieXnb9aDTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270825; c=relaxed/simple;
	bh=CWxIM30/ZytwZEurcpfKISIt7A47UeavEgBhqgXYqxc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWmXUPfD1tqwaBZL1i4lRUd4hRCYOFgp4DgyF1Cd2cyPugfXu3/f4g5zai6zTzyegP7V/HAq2IwhI9Es3CqgtOE+eVo19dhB/yMOqX8nz42gPlbP8+NbDi/K8WUmwDl0GPi+WDL/ousUjJI3GuV6B6gNY/6VLRzXO/AJ3AdNL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5LAJ38E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5LAJ38E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8D5C2BC9E
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270825;
	bh=CWxIM30/ZytwZEurcpfKISIt7A47UeavEgBhqgXYqxc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=b5LAJ38EmRnnOKq0TEIuH3vuPBSe3qPPb6Ry0r442EDFgZHO//gickKm5Fa13Ysas
	 TTzOkaThunij7Ip/BWNNA5lEi/apraK8vsLt+VcDibf/WmPgSSlZc+aEiSu/kbsLha
	 zFbFdsr3zIRc8MRUM/ltpPlh7HsHG7mGR2VHriwyFUj05gomHRGqAY9StYcBg94Fg4
	 31soFujLoNaQOsS1DENbuzW8rL+BWjPAu4YIQ7YJIRDYgTM5BjX5347IauMQyHW9oR
	 yRCep6+9b8/fllX75ydqoua+70wziZWGYKD/CX+vvBEIUzo87UdxMaq343abt3MEvC
	 X+GtWHHeshelA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38be5e86918so1026381fa.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 06:00:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIM4eDlnVhA0uzR5GN9QG3T+mnNdzUgC9fC/6SCyokyHiUOUJk/6f/XzJl1UUAnx5hmOvoYwIfNdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkGXg4zZbXrgCSMW3oj/aOqdaiyVzVqb1ibsmDYx1P8fYl8Kb
	GO+84FSsKrdagI81ik3ihx4PkgnCQtSznQNNwzEdv03HlViQT7oyPMvs8JvBnIHJbwUAI0O3vzr
	O3Hru0joQtLKoUrkozbQVjS4a3zKCnGzmAeeHf2YmVw==
X-Received: by 2002:a2e:8e6f:0:b0:38a:34c8:9dad with SMTP id
 38308e7fff4ca-38bf97215b9mr28185691fa.31.1774270823825; Mon, 23 Mar 2026
 06:00:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 06:00:22 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 06:00:22 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com>
Date: Mon, 23 Mar 2026 06:00:22 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfvOR5AKKyDNNXpN+xceB-_sriKx_ZBi4NXbjzLHdfaWg@mail.gmail.com>
X-Gm-Features: AaiRm50pkAbHouhDkC21D4RCu6Mdaaal-AZUTkQxo146P1qudcheTUv7aWyJvIA
Message-ID: <CAMRc=MfvOR5AKKyDNNXpN+xceB-_sriKx_ZBi4NXbjzLHdfaWg@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Fix device node leak in pci_pwrctrl_is_required()
To: Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 12:05:22 +0100, Felix Gu <ustc.gu@gmail.com> said:
> The for_each_endpoint_of_node() macro requires calling of_node_put() on
> the endpoint node when breaking out of the loop early.
>
> Add of_node_put(endpoint) before the early return to properly release
> the reference.
>
> Fixes: cf3287fb2c1f ("PCI/pwrctrl: Ensure that remote endpoint node parent has supply requirement")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/pci/pwrctrl/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 7754baed67f2..97cff5b8ca88 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -299,8 +299,10 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
>  			struct device_node *remote __free(device_node) =
>  				of_graph_get_remote_port_parent(endpoint);
>  			if (remote) {
> -				if (of_pci_supply_present(remote))
> +				if (of_pci_supply_present(remote)) {
> +					of_node_put(endpoint);
>  					return true;
> +				}
>  			}
>  		}
>  	}
>
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260323-pwctrl-fe840d733443
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
