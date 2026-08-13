Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506D48D874
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641995; cv=pass; b=qJlcfvhL3U7lofVWoNwgtYJjdf1dn6cz+zZhIuMvFRDurw9s9dct7uhMnXO5huh4JfJA6qPO9hJW8creohO/SEbvWUi8AVZVCYQM+jAKdKzfKWoUfIkzkzoM9Rcclt++L36o8XgIzuECE3eZYATBE1VgpWp1dQj3vyBG0xaN8ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641995; c=relaxed/simple;
	bh=9n9YjgvbPEjwNFkg9Oa6LtGpMJu/9bj4KSEll1ip+Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv6ZgE+6VbKA85ZnTZLyF6LHZrCiUwqkjtDxF0RXsbFgzh5E1RGySJr3oYK4VwFqB+tkxd12b28zDoRxcqT8cU7xJ26a9Cr3hVcpxOpDqGlb9D+TPslDFHikDe9WAZZTbVTC386QqpQzciXkEA7RgvalIFwKkacMKKwdZdHDoJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW5/V2w4; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW5/V2w4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so1471081e87.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 10:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786641992; cv=none;
        d=google.com; s=arc-20260327;
        b=aXWiKdvGcod4AXSHrpHNqnM64U0rzPR/S4WLAA2CJ4y7+wxk4VvfsIvMTC/JHH7tPN
         UmUsE+15wMFf0EN4h+2jvid9ZJNzi8pRZg8zP1JZ6gX1Lt0KESh2hauYeqBwqIjvjJ0b
         i8v8NgWEozQhGgwM+HNLkQwimrnvPLFQPmfF1OCB2BSPjIr2oQgWRmTaMkq3QbaviHrG
         R06C1FtlsLlGyTb+rqve8FaxdKbLhpVLnwnU4zFYzMRmdfh9edR8VYRl2RebG5CgA/Vm
         33WrJJAkXMd/WlqricFVblm9I65IxHgZLBhd9LQp7VAoOldkz5/iFulgQ9Gbmf4pHSBW
         vhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dGcfFS+7hS+n9L3WjL6EpmxEX7LHvUATyMdqsvRvBo=;
        fh=hFz9itJR/qZJBBHOZQWT65und9jbjlWeRgguwQcsD6I=;
        b=QsL1n9fqK3CIAB/P5t18zsfYWP5lgcWY2Kq4ulaRkM5+yHeJr/eR1Gck2plim44k7E
         dF+ncr+1qXPXlY/vbZlwKN4y6DtzG8SavkrpyRUBKxX1rxU88iiKR/bjaeeiHwKAiuRf
         6i3Fu15jhX0j+aMh632RCARmVL9VP4sfcBLH/41+9eWKxJ4sh1wiEH3J7E+Mx4oNwLbH
         dl6/TexWgm/HWOpOFLNH2FutJzF8VVDbCoExTFfVihmuODcbeoHNYc75y9XE7Q4BKbWu
         Sa+txpS7ByqFrdtZ3xizBGz3Qrm0/+pVwM5zULWZ8dJb/BMq25+Cs7rikgNIQbqDh6C4
         eeNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786641992; x=1787246792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dGcfFS+7hS+n9L3WjL6EpmxEX7LHvUATyMdqsvRvBo=;
        b=AW5/V2w4jR306qAftuXbLWtvDQm3kJLqtEAcE4jVQU+hrIuGw7sxN8h0WMDyr3FYrG
         CbqjiyQ2IseJHW2il8rqvQoD+Ufcvz/apin/ZjC9wdiTVhygCnt8bMp1Jyq+I9iKKfzb
         FYZ2E3QpuhCjT5r+Ue6M0MtWoWpBrQZiB4ZwxW+zvYntATXEQxMLBMR6XR1ANo+cURIE
         Mf5iXnjJJVJNiRwJGFTYKyLAKQbY5W/gfp82pHznxixpC5qQ8esyrj0I0Lv0FdDSEI+h
         HKLlUO0+S5WRKwqvKRrkyoXHbNTJdLU+ccE9rKnITpD+GqYElrxmWuLoHBDDUTpgAzqL
         EVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786641992; x=1787246792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dGcfFS+7hS+n9L3WjL6EpmxEX7LHvUATyMdqsvRvBo=;
        b=Z6d1F9cnRv31JGbxJWOd4EEJA92hJ23B2bFGf4bIG/1JFtw2WVlRtMKPlB90V7+bxY
         zaC3tLqyrj8omYYm7gpRQiOYKb5JTGkJiXkXlrEGFGdPYxTMOK2t1M2TRjsh2zCkrLww
         VSJ3+8js29+aJv1aWBipiU96Hnqbp3BXGGb9bY4HNBawll38AlkrPsUd8s6NxTZal5Du
         acCUOA1eHlwMPboH0woLDW/GqkQDnw9i9qX0KeYApKeAcpdez8C5FC53A1x9BE5CHRUd
         xg24sMj+zjFpL/eIBa/AzQ2Tqgu+NS41oyR/er8Y/h2wEDsfv70K24zbHIzYYbTX1rPr
         afbA==
X-Forwarded-Encrypted: i=1; AHgh+RqVcYdjqPGT2rDdxapfV+Z66cc0cApTepKZNINCQgnZWUSKdfWjl3YVV+nsOuGipbywYPHJ/nirW3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNa5F694mck80TmrN0sOCQJOmI0ZH41Ir1ZwQqZnYcVw/tPkEZ
	KLVcHGEB44Yn96HdDKXo2ZyXQ2oilV8tfDhYSccECY+uRQzX9qmsi6t9dWb81STaRByc+WvHigT
	9k5VqUe4jVVJdmLblUCu1q0YbcACDBoM=
X-Gm-Gg: AR+sD11GC94k6Gql3oZNUx8ZovTVygRgIszO41ecKk9mTgIzORaU1HKMZWSVAwJZFm/
	OrMHHhGBAiMzqk7aWe1x6nu8nljSjTr7gO80FrQ/51QUnq5yubwPI0cz+yuzg+plmjerypXHsRT
	zgvcw8liThs2B/9hcShGS5CxIWmdby/OaEYizgTzL9O7iLNZHUIQ4lHEJGelZVXHNW5DN6ENSaY
	7gnPXWPgRo6ZGkAZUnfLY3kENhOMhOcSMITkUNj1Jn1lupgQXD85E3LEji5CXaAxXPFgGNvmCCi
	ddmbhNopNHbNSCrtxBeiT13swQAM3wm14WQpv6an8nfYIg==
X-Received: by 2002:a05:6512:3f25:b0:5b1:4c14:9b3d with SMTP id
 2adb3069b0e04-5b453cc57a2mr1544652e87.11.1786641991684; Thu, 13 Aug 2026
 10:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781622998.git.geraldogabriel@gmail.com>
In-Reply-To: <cover.1781622998.git.geraldogabriel@gmail.com>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Thu, 13 Aug 2026 14:26:20 -0300
X-Gm-Features: AUfX_mxjuOfsACV2NcpMvanMb2F3tMylLUszlHpzH8YkVOIfS0W3_-lZ3FK3lac
Message-ID: <CAEsQvcv7AddxRsy5vr_pkTYPs0zm7w60NxxpS3r2_va68yN5Ow@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,
a question to PCI maintainers:

It's been two months already since v7 with no response anymore from
you guys. Is there a specific thing you're waiting, like an ACK from
Shawn Lin? Or perhaps this has been forgotten about?

Thanks,
Geraldo Nascimento

On Tue, Jun 16, 2026 at 12:24=E2=80=AFPM Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> Dragan Simic already had warned me of potential issues with 5.0 GT/s
> speed operation in Rockchip PCIe. However, in recent interactions
> with Shawn Lin from Rockchip it came to my attention there's grave
> danger in the unknown errata regarding 5.0 GT/s operational speed
> of their PCIe core, including data loss.
>
> Drop all code related to 5.0 GT/s operational speed from this driver.
>
> Endpoint Mode driver was not tested.
>
> Changes in v7:
> - In pcie-rockchip.c (PATCH 3) drop unreachable code
> - Link to v6: https://lore.kernel.org/all/cover.1781207474.git.geraldogab=
riel@gmail.com/T/
>
> Changes in v6:
> - Squashed patches 3 & 4 together as suggested by Mani
> - More formal warning message as suggested by Dragan
> - Set the 2.5 GT/s bit regardless of if link-speed is set to 2
> - Link to v5: https://lore.kernel.org/all/cover.1772239598.git.geraldogab=
riel@gmail.com/T/
>
> Changes in v5:
> - Changed commit order to not break builds and adjusted copy pasted
>   commit message. (thanks Charalampos!)
> - Reintroduced behavior to force 2.5 GT/s in case there's something
>   non-default in the DT. (thanks Dragan!)
> - Link to v4: https://lore.kernel.org/linux-rockchip/cover.1772169998.git=
.geraldogabriel@gmail.com/T/
>
> Changes in v4:
> - Incorporate suggestion by Bjorn and refined by Dragan to drop the
>   "catastrophic" code
> - Link to v3: https://lore.kernel.org/linux-rockchip/cover.1772057799.git=
.geraldogabriel@gmail.com/T/
>
> Changes in v3:
> - Clarify warning message even though Rockchip won't disclose details
> - Drop DT changes as they were applied as subset by Heiko
> - Link to v2: https://lore.kernel.org/all/cover.1763415705.git.geraldogab=
riel@gmail.com/T/
>
> Changes in v2:
> - hard limit to 2.5 GT/s, not just warn
> - add Reported-by: and Reviewed-by: Dragan Simic
> - remove redundant declaration of max-link-speed from helios64 dts
> - fix Link: of helios64 patch
> - simplify RC mode comment
> - Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/T/
>
> Geraldo Nascimento (3):
>   PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
>   PCI: rockchip-host: do not attempt 5.0 GT/s retraining
>   PCI: rockchip: drive at 2.5 GT/s, error other speeds
>
>  drivers/pci/controller/pcie-rockchip-ep.c   | 13 -------------
>  drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
>  drivers/pci/controller/pcie-rockchip.c      | 14 ++++++--------
>  drivers/pci/controller/pcie-rockchip.h      |  3 ---
>  4 files changed, 6 insertions(+), 44 deletions(-)
>
> --
> 2.54.0
>
