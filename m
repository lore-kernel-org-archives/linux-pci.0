Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872368;
	b=Ytwdd07v/duHtF+BmAZe3PjnkCok8taBZWD0xM0dFMrhwjdsDTMYHjeAgeEe8p2IEPc1
	 tQgSfaDGKjAIlQHLGJPeoQqkY8n17WjASA7SitvM44NNvgUx4KKTNEFbX0BuuhG6BKAaz
	 qht61PLV+aR7JFc648RBZJBJwlJYCtI0dqc2PC3klSQEtKxDbvaeYLgLofPr9h/YovZWr
	 2JIejKYlWwwxJ15qAEKWbjspk5vSC1su7RVsnCKIXK6prvV9wDiUPYRvAyT1QAMrkZuB9
	 o4JMXb5YnrHIbifLZQbqJgUgm9P6FqUG+VDY08vuu773dkJGrI1XWPCinGmWt8EZGBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872368;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=gSV5g9jWCfQcVgT0nKrrb9f1JV1xGAuHmRuADqupxC9QI/BxkUAKgOikt5pkDc+SdT4+
	 ngQa/OsdTX4GAvc6kCOuXtAJC52b0uQrpKuRe+M0IKMmPwx39G0uuwI+nOe4yChwXqNpo
	 FoqWygQWk9+CDIg1CE4swBSMVnAN5DvRx5oPBTr5KZijsbNCuWRj2fzo88vsXg01ngomt
	 ZADz7upj6lLqju80b6ig5aObCSQsYyzWRU6WRgDpJ9Ac2186Uv2ioJS7XS9bxO+b6iZFP
	 +ZAN/nbpyS97IE7XIWhpfpddhMYJt1eICLfflHQwzYKgsez47OJr8rygHIZKvp1GLdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE9606A331
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 09:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBBE9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533778ab0bdso18448601cf.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 01:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872366; x=1794477166;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=zg3ChOlzC3km4NTSPsf0LJzWHiYsI2k0yz0YFte8thcKsKVn5SzsuaOTzhhy9zvFHl
         UhbfkWmy7qbCmlJOE06o12+aHWeYjs0qScOb1PR3Cwyj0ozgjDiHqOGXy3W+SorS07W0
         aXImksK1Ga0HgPsJUqyAKL4NLVdoXfmw2jr2IR0+7VvThKAzArHyXiU5vZubRKLUhQWy
         Rjyz7Sc+hs40LsIZiPGrkGwzpF6k8DBLd5Q+Sa+A4+yF5p6fWGTm1gNj5Lyx1dgdv1Tu
         1tE4ndZ5gejbR30K3Vn2JwsFhqCwZon7jM1kWovhNI75zsR4K4viNurj9x1HeasQ1WZj
         sB9g==
X-Forwarded-Encrypted: i=1; AKwUvBwEnL6yY696EvbMkY/szdX5+i9R0XYIPJzCqAcq02YVQ60ghL0N7DcLDPzUx7Yzv6H0H5Ms9AfiUGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/72GrKvvjZtnNWsG6CNwlVY7BCng+CSVVDPg0eVMmYiaz1/Hdz
	I+zitJfXP+ueR/dDPS+6lBrgbkr1Zqq+NW/BngJy3bZy8BZBfIKlR9n5vxXjlEChOh8=
X-Gm-Gg: AYBFou14xvhLlHmvC6+L/btYaoEsIsoi4fdAdseK6QR7BcyIBOyzmG3MnJBZunAlQ7f
	cvmcFh/YGkNZ1n7uPWyblLUgXs1rzlfoxBA+T3Bv1iRE8+muwCRIMsKmgyjyz773WpZ6Qq/YVyn
	fSdDD3XdFXL/dDAlYwys8uA3a/4e0njVKq36hwM1kemdBw1mXJjED8Mc+IQtpRqFMvzs79YvPMu
	dCkOLTGIrs6OIX4cxDai7lQEOOFlR8JmnNf5IrmSI0UYKpoeLrw7Jd+a4R0xcpP4udev3azteyo
	i2U0id66xLibf2pb0uBpxD00q4MXziaFVBbX4suhhABsIqs0Bd0jT4gtzepFyjLS6umDdOTBHBS
	ZSgBCT67UKkf6yx4/a5YP2PvnHl73QJ8njFlc+nwI+svx5+ejyNOygnz3ZIMn/Kl7cGKbb9smoH
	V0Zw3OzMUTizXnIQPkp0krxgf/WEtMGYDgGIIKMhVlZmsIVELmVyYc8QWgKy/+strl7dmiLYpjF
	wtoEJAtNPUJz0bnRF/6sDwbHJUghn/o2ZVna3GSqqreT/lwKMBpVQpn+xJvTvHwvz7pD7YVo5Yy
	dV8BwU6w4htFVAx03Hi2Ooli7LqEdt9Ry2Yx4e5tWlCZvyYnKxgq+SiEjbLnMu0EOdUIOX+j+83
	SqjlnvcehxBJ1pl0=
X-Received: by 2002:a05:622a:e11c:20b0:549:ca88:cee0 with SMTP id d75a77b69052e-549ca88d0d1mr98236521cf.5.1793872366511;
        Thu, 05 Nov 2026 01:52:46 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e987cddd0sm12807446d6.34.2026.11.05.01.52.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:52:46 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365f9a04c5so23473911cf.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 01:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx+JuHrdLgWziCQ7216SLg7uY08ZGpxh3cz6/VXvn/UIihy1CUHkUcEUIkXRt/oIonkoVfGzvZ8lwo=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
