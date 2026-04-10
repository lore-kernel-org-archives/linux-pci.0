Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE63B27D4
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816046; cv=none; b=euIn9iH+6Nto5lcsvpFXX0zCCjsBVFaGc8H8+ZTna7uxgeEd1QvRZCsNHK9KKwhu7SSUbThgKYY400VHacADOILejCttgAMy8HmzvyvF6xooQOZZyJOwX5PWm2924gJqqL+zHOeMfEY5erH5hKtOYLgyb2GduwCTcIZTC4VjiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816046; c=relaxed/simple;
	bh=cNwNoQfVMvgb8u/WjV1yoZ/R0UlbAVcORBvRS9+/2dU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nOu8Nfb/mKcYG17DIl9jTXmJO41bhr00IKQr3omQnGDV6qGnVg9gnnuS7vcE7t4Ob/KJLplsxkZ0Y4KLh5Mxq5EK08aW9mdkzjuyp3ONwj/Qh6uieOx6zP3U1Q1eCSl0opgrpNCG3ClHksfoXjeTw0dv8BrIAvE6jjnMT9KBtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wohz7C7r; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wohz7C7r"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so17649535e9.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816044; x=1776420844; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9vi1Qcy5IQgvj+vG0eFK20Y9MjA+J4iFlYIuZ+D4fU=;
        b=Wohz7C7r9onfYWrFvgjBh3IKBWikOM4p7Zf+TXfABgiLWhDOZgaRfUIKjTfS0oJF1I
         TCGBKl2q2IzHHn7dUjflGYES8+OalyzCLrDLZAXoJOjM5WNMIrsHrWV9OjYqCTnytbo0
         NlIO9H78rHd7EUT1i5M68njKYEbB564t9XEtqwSxhywXUPRSAt/5JY/V745WAu8tsY/8
         4RySd3otojTOi098Pzk0O03EKF87H0szb+9xG33uAzPjxS3d11E/Gns6DRGfY6AfP03B
         9zpRQ471YJu3Z6ipk3xt9TP6hM645DUzJ2UYlG9zj8dIEzW3w7bl+8IzEoP/Z0tYzDT+
         wXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816044; x=1776420844;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9vi1Qcy5IQgvj+vG0eFK20Y9MjA+J4iFlYIuZ+D4fU=;
        b=bCW+tXUZVm9PtNMEDHc6vffs+XB11nO6fp4t8sq8gq5/2MNSD/623X/1WekNXtUf2c
         IVbkcNwNPCW6BJbbJD35xx2UOTuM8OmNTl3dzdV/BBrzpE0FEEhUXsNgQ5xcMwSOvRCY
         87JfgCYjH2wNjwid6QwIUw6NcLbyrdYH7b+rbqLyk13/N/fbR57FVLnn1nNzpms642aj
         C4zMlais6aAkWZ+sLhZtJwGs+ugwzPBonewCU/5lfs9Ic7U/BWa/OxXRoqzNlEJBIMBO
         CaoXGRe2PMv2gjO7SK+7gXJCeezk6zalBH3hxl+F18M6Zzb6tm700njUKEsJxMiWIsO6
         LzdA==
X-Gm-Message-State: AOJu0YzGd+ITvrZbZHJKAlubgcVNS6cVASDTfLViuLKG8Css9Z0Ve51O
	+42dQkv4Q7Oiv+YxRoPNpLzw2jfjpq9PfaYuhu0puGuyXjZC6THCkgmA
X-Gm-Gg: AeBDiesp9uBhvf3sw+huFeug+89LjsNPP76lxuokCIDPq76qSHBgAL4COQDIgm8eipN
	sIv5SaYqyIepa3dnidVJcH4xj6JzZQIJQIf73GCWMOWvlkfv06HPTKltzC7S2JnYavLQsgB7WoL
	CH4GbB6rfGklU2VzBlqLuYOoul1bzxO/EAusWXMCTlbBF+hixXzrVhymvMI8y3iS4IVnd4t6w92
	wlqCEOnAKOhHmycyfJdsqpdn78PrXiTVI8qYIPG8zZI8UBi8mskxGaKd2iBkdgd/UizyXGsUH8L
	BZRQJCgPq7hxqXS37SSuZhx2h42n7W6pnY4SE4FSOut0JKMSQdpVKI1zZXC749jZPfExqSPSTpg
	Q8rCNjffRFwJz+H+hrMVa8NZMYjKySV1nF84n2eB/Edq4RLHYGYxJo7ORy1O1N+GERA38lHkVR6
	3vtlUhc9GGtfXEQsxSSKQ=
X-Received: by 2002:a05:600c:a409:b0:485:9a50:338d with SMTP id 5b1f17b1804b1-488d67bbd10mr27672835e9.3.1775816043400;
        Fri, 10 Apr 2026 03:14:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm17034435e9.14.2026.04.10.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:14:02 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:14:00 +0300
From: Dan Carpenter <error27@gmail.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] PCI: mediatek-gen3: Integrate new pwrctrl API
Message-ID: <adjNaKB5KGpl6qIp@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chen-Yu Tsai,

Commit 1a152e21940a ("PCI: mediatek-gen3: Integrate new pwrctrl API")
from Mar 24, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/pci/controller/pcie-mediatek-gen3.c:1226 mtk_pcie_probe()
	warn: ignoring unreachable code.

drivers/pci/controller/pcie-mediatek-gen3.c
    1202 static int mtk_pcie_probe(struct platform_device *pdev)
    1203 {
    1204         struct device *dev = &pdev->dev;
    1205         struct mtk_gen3_pcie *pcie;
    1206         struct pci_host_bridge *host;
    1207         int err;
    1208 
    1209         host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
    1210         if (!host)
    1211                 return -ENOMEM;
    1212 
    1213         pcie = pci_host_bridge_priv(host);
    1214 
    1215         pcie->dev = dev;
    1216         pcie->soc = device_get_match_data(dev);
    1217         platform_set_drvdata(pdev, pcie);
    1218 
    1219         err = mtk_pcie_setup_irq(pcie);
    1220         if (err)
    1221                 return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
    1222 
    1223         err = pci_pwrctrl_create_devices(pcie->dev);
    1224         if (err) {
    1225                 goto err_tear_down_irq;
--> 1226                 dev_err_probe(dev, err, "failed to create pwrctrl devices\n");

The error message is unreachable.

    1227         }
    1228 
    1229         err = mtk_pcie_setup(pcie);

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
