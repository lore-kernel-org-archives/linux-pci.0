Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE273BD63A
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330993; cv=none; b=Rcouks14jzwTOsQhW61JN9QvGWWIT5JxlLem31zP47g7A4HA8VILI4sUaVECGdirIWe9RqzbvbxUrQECzWlyzt5PjarIS+FcInjbAf5HcZfZqqiHrSHjU+ZVSDOXE8Fao39xgj+FB9hKPSXu+KTuHniStD58rjFCg5v9O8o/WyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330993; c=relaxed/simple;
	bh=6J2VFoOheObNIbZ6/cGmHoej1PdGKGdAP4cvYQKgG9k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=p7Iceof8T0Kbh0cOqyjhymCOWxSyGQMJS4Z5gIXzIj6KY5qp5DjUgQlifG4MGcTiZIq2W+PZ0twaEpo3sQDT/5K79IssYnHx5+aJt2+Q2bIpO9d/QwOucWsfITE1393xjEd6k/wh0voLy/RCDAsneXQw1S6KGTbTyKu8loS+Jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OSLXgBtA; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OSLXgBtA"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso76901036d6.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784330990; x=1784935790; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1uFYFSRoCsiTT7zcdwujRzQUpLdsx92sk9iYHDH24xs=;
        b=OSLXgBtAPc1fBN6D+TAlI3V2si/8u89m4Ss6h6TzBVQwndwZG1WrSuuVIj2IbeyT7R
         T1YhXpxktUi+my932RxnpVn3QnpNzKFjfe+6ibMP155x1AGIsd4iKIrb7uL8nA1GAOFR
         b2ipVS7ve8eHWKayQrbqDvYPrFnE/QOKPqeH1QZ5JHfOwe/WFbHeAqEnM139GCPGfHFr
         e4ttlD9ttTr5x0oA7SBeCSe5j9bU5o8d7nOmtnlXuRcH0W2JcRAky/uCs76tsy1Kg6bA
         FZ+IFDx9rYnbsHWpu7uHIqAdvBtp1BEpeDYlx4FE8By1a7HK0B6MoP1cmlPjJ57WECY5
         R7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330990; x=1784935790;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uFYFSRoCsiTT7zcdwujRzQUpLdsx92sk9iYHDH24xs=;
        b=Bj35ytZBNnA3sMYBc0Zms4dCdf3AoPs5ZoZ/BkaMArqIGJy3h0dSi2B5GqyJYU5a+C
         ALE3aQrqrnX/44nKm//Mj4IgDldSDTw3CqRQ3iGc++fr5QB96jroHgHAY/Ymq1tYR/Ns
         7KayrT4bmAUcLoX35/3MsIo1QeajaWd6+jL5eFxU2KdGdYn6EPOqUUBkIcR8oRyjZ6Hm
         FDMgAGr7iMoPWjxaybHtVbjpLq5fvFSJ7TorbHVVz0/6OAJZH/lH4kPkjdZYsr1YOlMw
         j54hZ03rY5UoZ220BqBmhtrEs42exqK+D0YaQPy/oxbPJeR8gm0hqOEPAW4t7eYgieCj
         AT+A==
X-Forwarded-Encrypted: i=1; AHgh+Rosgb0kPOtGnhacqWYGKqLE7i+6vZonk5eDFDPFUpNl5tco1jCvJvbmOljqTmXXDufJfQs5hViEKpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTe6pNg+6Cgx0O1Rvh+nc8uZwGqOExXWADUEdcuy/JgZgWK5CO
	NnbP/kTFYNsSwjLQPJjxvhHwJ05Q86DVvZkyiJ66WxiZNi2PumjupkvNkeCYeiU4Wbc=
X-Gm-Gg: AfdE7cl6rZToM1yqO+k+hUkWrqgUDCmhT37HF4S4lM/9s6Bi6BWSX9nw7qVwfRk3ZVA
	cdt7u3wYpCtn/g0euDStaexEzgDMkhJTQ3Tz4qrct8aQJRdXzM0Rt4ccvR50r++1sXBGkeRzjXB
	LDh6RLeBA0BYs0dxsM5uVzcBduK0GdW2qgjtI2tNeLhH+Ejp6QLBDMFPd7DJT5v7CjPyN96WSuE
	jGNJia2sp+xd/HZZaqoTpKbSBELO0WXIeFPmiYb/B70JZ9ZPgtYC2UPcU7WpO6D7/5h7N0fh+Ug
	FkZfiV5BUEE4w8API5yIwU5M5pYSriHItxxHGwTDAHTb8gE12Ucr+FNvXpmT2EJiJpUUHoXZade
	HSdtUenoxrZ7XNdWxp2WLAB1n44Sn9SdF6FlFCNt58GThU0xSKUfsnBPirYQrdyVCiE53L4jWCL
	/vimAnvSusTgcv09vOQYafW8sxegESImQNdYdiImy9Gm9iIpxn5g==
X-Received: by 2002:a05:6214:5c49:b0:8fb:81c5:7997 with SMTP id 6a1803df08f44-9077850e2c1mr54008216d6.31.1784330990189;
        Fri, 17 Jul 2026 16:29:50 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907787298b9sm28260406d6.48.2026.07.17.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding
 Enable on preserved bridges
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-10-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-10-dmatlack@google.com>
Date: Fri, 17 Jul 2026 23:29:45 +0000
Message-Id: <178433098576.189683.2364970585754668266.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=888;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=6J2VFoOheObNIbZ6/cGmHoej1PdGKGdAP4cvYQKgG9k=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWrrshWLAQfvPS4hCFjntJqjX0KdHUleGb+svS
 eNoqDsCDGKJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalq67AAKCRC7dyhM23N6
 3n6BD/93+EXV7xpXf2NVyjjavXthNzeAZsOjnEaI/9CTjGZpZezuLCaFWFkZbkDaJEae3J38p4g
 juh65pYyMlwdowYBLYitqy4Ier6vbyyxoTsXaj3h/5m7FYus2rP1L70rvxqIWUKVDa7ae4mcHP8
 jx4t1Y7WnDY7cDIIBbDBOVWz/TUe4B/nhCyh923/V+f3mvMwSMrkjpeg0snqGfcXX1/MgSHzSXx
 JxlP4a0WAMxKCYZJErzZ2J4BDcRpMPVf0Wogx/PmJlJ44HAR0obpH/l7e/l8mlIfJyTBnC0BOcd
 CRxdwB4gQwt8tYXq6ojekcZQGo5tkLGjVU/FRP9nzKbGUoIwwajPcQw2k9Wy0QrUHOHr0YepxNa
 PDOxIex+hWFFkDdyz0K+A6aSa1S8Wbkc78gHQcx++rNOheuVA4I1tNb2mW0+CmOfdK2W+Xq7qzU
 8H4RB21Ijq3rJnHjvcfH9Y7rNyN0XbXdraIJKmVcg3iQiykYkN033FyDlHK3Xxs7+VkXpfehQU7
 HVwPoEC6LyiXUZuPvqNPlP9IBcUFEKJtHRGZQvO84eyZvv0IyG2a4olE3gptNO3xeHXM5rLoij7
 +UQOk3YJ0MWvmomRHmA6P0cgqW7ejMNyEJU2GfTch92NagNbGdNLnxWPd3YVdcov/hPE9GI6NTE
 y4FR9mOBy865agA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 10 Jul 2026 21:26:12 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a95bfe5eff77..74a11e520f0d 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);

unsigned int    ari_enabled:1;

Sashiko asks a valid question, what protects other bits in this word 
during modication?  At a very list a comment is needed.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
