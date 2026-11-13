Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530274;
	b=UogA/tMXUcdvbDSe8RU1k634YDxlN0Z8Plc373gQMvBp/kG4XO1OohTG//juqngmJJNe
	 u7ACnldqY5sUhzYYDhLYJpx1bX2dkng7Pbzj5qFjnyqEJyffghRPgOe3BF5Lj/lgmhe9x
	 jIEKV/TSGKiN84TX0LdGHruuNsKVhp63a+W9r03QGxIkWWivwnUbwL7Z5CwzjX32pFZpL
	 FeSW2odFITtO/IUUCeHtOtF949q/yBza0JitE1/6kJ3RCfGEc/o7La1WRu+hv2uP/+Zqf
	 DBBDtcjAJcI76dJjbtJ3anicFCdQqqhjnPpoPLELNG4SFP85LOEVzr7SYkaEzgsXtKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FzODplEKs+WHcm/+4H/RVQkgIn8A4rJ2dXxs9VQSrPA=;
	b=cP0JnFeEruXMmZx15UfciFYyK72Flsu0i82p1BOZKPB6MhBY0eKZoIHpRO2WauDnNvkw
	 MBJ+8R/kQaihw3u2FcafiHHJDM6UmQ3LH88qJ4VhUFH5QAM4Eie500vjM7+MejjsqcgTq
	 mGC0X1GwjrYMp67M90PQf11Wb3lVV4E6qAMM5aZAMPlL0Z628AcVtoV+4t378mmvQ9M20
	 C9AdNU596CJWFIVL9eePzXWsFSRIZ2JUgKzdEhlATAFp/y36Z18TpfqVoLO1LPX57PQYX
	 /e7l7OI5ewls9B69C08fR8WKkyxLhPO46s7zk0ATtOLf2ORq2c4dsyULE3x1Wlxm5OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sxk7TyAf;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49736606A331
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 00:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49736606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sxk7TyAf
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4919a880834so158679f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 16:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530273; x=1795135073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzODplEKs+WHcm/+4H/RVQkgIn8A4rJ2dXxs9VQSrPA=;
        b=Sxk7TyAfvprMUBLPfRxZq8aZbkD3Mu/r/W0AmKA18WTgowz1bzDUXazJ3H7HFiqiXk
         rJnBD58mhnP5pAz8goQBww+UHY3mmCQZ6AfWtx3SJcMKa6bvp6E3y9MPYrJEoKpvAvwu
         xL0f80PeJ4D6g2XPV5kY4UuEqIW2o8LPhhEfFpfSvVkxLEJZ6+OsSrzi2zvNzdbh1cr8
         fzmmLwjPSWSvzNwfc/RTBNHYETaPI+gS7kBhuR2ZSSE5ot9pANyrhLrY80ekUNW1kjE6
         k/a3tmxzWHTCOK5iBCwb6ATelKk8w1dEQxNS6XwxmWKgIKJGWoSf957/ETiAO/hEVGvC
         jL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530273; x=1795135073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FzODplEKs+WHcm/+4H/RVQkgIn8A4rJ2dXxs9VQSrPA=;
        b=QvPGzZ/cpRlNYO1GsNDuI7IxS5AZnlT+ZKhlBXo5SRejCNll/ZkfxIzVOuaLi99T2q
         iwyH132dEzJbF0Zw08xPPHGUjIB0kah6L0LaG4/ghrt2d/KPnyBVS9/XLXOn3HFyzlnW
         A7W27sfdQbtJElqNGbVE+0Iaw4XS0+pAtjj9ZkKjyPMv9U6e+ky+Jf7NpiAJJ/uP51Lh
         zHcRh8iLkuwt5NGWUHelU+hIxo8Rr3fiVjbsqy887mGE42B9YvKx4x3NVStmc2wKK9qb
         UYWbYh1Dm/7VHQXG8FrKm2MNFauW1UXJK6laYie8Iy/UKoWPbQWfSgi/qTuBWL3SWkSz
         PDfQ==
X-Forwarded-Encrypted: i=1; AL+hErHacwbfhVrU31u0WasvrQHLwgf93AC5MxGJp4RT9ruhrEFtYrfvQcSbXhBjjg9iER6mUQfEmTumGZ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ulLGl4W9DgEbPdu73/TLEhTkxEjha7qLeL2z/kfQhNTXUnB9C
	Hz7U5r4NnQVbNzSupyEPCkyQugE4p9y1G/5k1Hu5lpdE019C9r6vlPn2
X-Gm-Gg: AYBFou2HMCIhJMuGzBjA/8NBQKkMYLmphi3kFEuSEMsKurY1UmKUB/yiEZvZNw0b0jy
	ykdEAfbIGtLiDoA5G0l+dXCSnzsO+Fy8fFprXSapmMnOVu/U+9vArVIlOmajBdUTIVmFgduvBB/
	YGu39DwXtfcrXlZPN+qYFlwXP0rmIlt4+GjE1ZCta0WcwgrrHVGAT/U5c4rJ+vnvJYRsHE061u1
	7zm41ELwTiXwpzlRTJZn6gN4cL3YqRV7lLHqZDcQgzYWeB9lUvUBTaPYBhmZ9mpG1CU7UaYm3gW
	JTmfoXXr/yMcEUxqM0UXaO4AsyOdfqjmMA6k20mBf2+2rHRJxo/7wepA9yYR5MLIRSEGMdRNr3T
	RxIRjMTJobwStR/dyAT87J/069AqMyeE5i7pmzAdoi81cbjkooKkkaFgb/dSpi6VGjWoqp2QKiu
	qiZpWxcI3gx1dbRpOvzJaesdE/kt6RE/mOZs8of0s6+fKf1EUG6aNFzNKranQyNxDFw6Jqm1eqY
	1+ofccYTDc2cxbDthv1hS4KHaeyhpAMOPpmcvmmQ52Uu1pXVwX/O0Xa79ySeSod3dRCCcp4ft6i
	D6VOpcgj/qTf6qoCw5ScmH+05KEcJQViWdKdmP84GwXEiXfCqwdWKawKd2l39LMCVnaQDyIsCkj
	4Siyc3/hT5WBofkRnDDuuKMFSQimYYgB4grlyUzZg+NLvK1gf5KzLtrkBHlM8ji+EvCcRCcnVVM
	Ri+SRrdycUcbtgFAUs3JUu5sYZPWWVuFRX6oAZmGU=
X-Received: by 2002:a5d:584c:0:b0:493:c0a:5087 with SMTP id ffacd0b85a97d-49c72e85557mr2540807f8f.51.1794530272663;
        Thu, 12 Nov 2026 16:37:52 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c0e31sm1741922f8f.19.2026.11.12.16.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:37:51 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/24] dt-bindings: PCI: Add ZTE ZX279128S host controller
Date: Fri, 13 Nov 2026 00:37:50 +0000
Message-ID: <20261113003750.3668725-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027214010.GA1212169-robh@kernel.org>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-13-ghahramani.navid@gmail.com> <20261027214010.GA1212169-robh@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rob,

Rob Herring wrote:
> Drop. No point in -names for 1 entry.

I will drop clock-names, reset-names and phy-names in the PCIe series.

> Is this for PERST#? If so, make that clear.

I think so. Both slots share one GPIO, and the driver holds it asserted
for 100 ms and releases it before the links come up. I have no
schematic to confirm that it really goes to the PERST# pins, so I will
check that before I call it PERST# in the binding.

Best regards,
Navid
