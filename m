Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EF37FF5A
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518526; cv=none; b=RDhM7tMzUfNJ5q1jcX4I9LSkagsijbqGweWasDlwIl8AsYLkzKSN6i+3aZNf20fCjcNfti7xxN3f43RAlZdm2KMxDt9Di7mj4DS8JyvMc/SY4MTzuT395Zh/ouCrT5NjIi2GgSNdm892POMCD6UmR7iKD6Dfx2UErwePY8IWqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518526; c=relaxed/simple;
	bh=HRpbfYi94SgnlAPxJxXtY8AqbVnyCTReGeanHcSFrmI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=p6R258jC2lW6bSyRcgEPNEw2ZSx4rJq543yJCCrh5RTTtdF6/I8QzlZsW5CRTT6ieUoIqcSqsXzz9j+ii/WCMPk9gofrjO2wm5YjcaXe2lz241p8nSd6hJer2/jc3TnRJW1VOnU55PGwsJs1WO455IGGJjcqHqWPdywvJ25mI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1BcdYnw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1BcdYnw"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aec139da7eso989287e87.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518523; x=1784123323; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+0mdBAgPT5Lu8N0Tz9pyH/A6lc2i4NyL8yHI0E97ZM=;
        b=j1BcdYnwN+n314TFbi1I4yjYdODUn46g74Qi9ACqVmD5p+/LiF7GVrdRUWxM0cadTY
         FtFGPwNDdBhRglcsnMSWxDr1iB12KevItsNT+bFqSgZIDcKnUsOlTIGIJxqoyVsttBcb
         po1/+IyKcu4BJPjNavvRCvKuQU2S9r435gEfyEKD2NcufKMHtRfflkgDRbFglLXTN6rb
         MNR6FpzA3CUGY/VYMTD1OfRKwcyNOX+sD44VG4XQYTDiwlCTrTwSdD3O+Sk52lXn4/lO
         jkNL0T21c8CQryJwr9Lv4z0zO804EEnZD9bDzG2F9b9GnES2lDsge/AYablk/mRszYIU
         9eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518523; x=1784123323;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J+0mdBAgPT5Lu8N0Tz9pyH/A6lc2i4NyL8yHI0E97ZM=;
        b=gKeMQZ29A6DQe0EomImgfEZ9IzpkUniiup0tTc/QGb7hHheAOSGSRarCYDXC/sv/gH
         mAYMjaHBzwxSv34b7SAjaWRfGVcwOYEIjQCTe4azK+tRJcYvt6LkjM8gb3bRGOt6TbpO
         d7hFZz5J1rfKFXNdPqKoR5dS9gZDbLLMbSU92Cz/frIR5w0pJkI0AyDJHFzVxDxRk4rS
         w55K6EbXmBvNjojPv0NmkdIA//9eYalKYJYzvYmZ5QyAvrnLRoGGL3njZ4zv/WaAoUvU
         uKLr+R0WOgHadFA26pq5orADT7LX557KxoH8dvMSLOX2t49KeI2NwuoZwS6VRG/61Xil
         UzKg==
X-Forwarded-Encrypted: i=1; AHgh+Rppy9fAm0DpwD2dBwHrv2iD5/yPZ89PsKaZIiTY0to1IdyYBRRqyu4SfwtQe5ChMAgixlNKiW+LwQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5PBolfLVd1UkhdynUZjZnSCztN9Z1MPSigkkFMIJcJnABSzy
	aG0g8YXLoMPRu+DT16AMtZHH1CgGPz3QE/D7X9qQhvc6uhlBp1QX+Yzp
X-Gm-Gg: AfdE7clIepOBuKO/dj+P5Z/RRydBpEE26tgFO4W3NMqLYve4ij8Rm/DXWMeJeE/F9sd
	8JqoTB+IN3hXzAP5vngIk/GgsDoBzQaNbUnV0E/sEqrG/bF71P8BVQzZTIcSTjIOJCh2ErD34Gg
	lOmyxgfOtKrRpuCQcvG5Dp7jkx2pIx91o4y81NAoOMaGQYe8jnub75dHQ+3WGvP+cRbyZAnLzlN
	37zD2pAMuE114rEGKpPu8O5SU75pDdgm6fy0PBYtdgPBOFwRlRm54qWjLkye/TiuFDkzDDEfZFb
	xmWIHGN++X3WRqjyLRr9qCpwVKrEK3JeYgJob2ROnmKRaAYIGKfiqfrGc4IF5tlb5KCcUPNmZgb
	LsaP0KBv+buk8mgwhZG9KFJSQbbi4se8HatrPN4Xn1lbWVntEByYo32QL4QcTj1idKmO7o+zjk4
	eV3kPegN+40vQ2oufTKQClevhTZ80TLg==
X-Received: by 2002:a05:6512:1417:b0:5ae:b4bc:9109 with SMTP id 2adb3069b0e04-5b011492e79mr609428e87.10.1783518522775;
        Wed, 08 Jul 2026 06:48:42 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:eccc:7ea2:9458:892d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed136f8b0sm4522878e87.4.2026.07.08.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:48:42 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev,  linux-pci@vger.kernel.org,
  driver-core@lists.linux.dev,  ankita@nvidia.com,  Alistair Francis
 <alistair.francis@wdc.com>,  Lukas Wunner <lukas@wunner.de>,  Jakub
 Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
In-Reply-To: <20260705220819.2472765-2-djbw@kernel.org>
Date: Wed, 08 Jul 2026 14:23:42 +0100
Message-ID: <m2pl0xboo1.fsf@gmail.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-2-djbw@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <djbw@kernel.org> writes:

> diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
> index d3f3f3399ddf..4caee7d55303 100644
> --- a/Documentation/netlink/genetlink.yaml
> +++ b/Documentation/netlink/genetlink.yaml
> @@ -153,6 +153,13 @@ properties:
>                  enum: [ little-endian, big-endian ]
>                multi-attr:
>                  type: boolean
> +              bloblen:
> +                description: |
> +                  Marks this attribute as a variable-length blob that may be split across
> +                  multiple messages. The value names a separate scalar attribute that carries
> +                  the total blob length, and which is sent ahead of the blob data so a consumer
> +                  can preallocate the full payload.
> +                type: string
>                nested-attributes:
>                  description: Name of the space (sub-space) used inside the attribute.
>                  type: string

Can you add a schema constraint so that bloblen allowed only when
multi-attr == true and type == binary
