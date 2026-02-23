Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88136BCDC
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886997; cv=none; b=RfEUWkQXm4vEZLmNp5IKh2Kny4oZ6txg+ckzzPSAdu4AUvkG9LMgr4Tr3+SXjCzG+TSRWBVg1ozehW42mcncPCKDEkCYpPYLhq66gVPkx7I8GoZtnlP0qHuaI5zavVsUgP+1FMn7YwCy8Dxmn/3iE3BhzLTyIVMfiQ+BLOsdFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886997; c=relaxed/simple;
	bh=RujqTiI7tS5XYd1RkE/7xBRNLuGPIBC6O26BaywrKVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzztmKwi98TCv8+kXkzUZYR5XzczO6nXnXa9XqTvbF9Zu5qjgiXsPN/EMauQmrQQ+YKy9W06pNCqQaLYNorMlxrQdSDmBI5gOkl3IbhuuXy4k0IISMKSlw/Kj9AEXtZFNH1MQQsc64a/zNUlGBr4heZKWrrokfTmGt8eloG6TD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XEpUI8hI; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XEpUI8hI"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdac83a6a1so184697eec.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 14:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771886995; x=1772491795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlvuMA+2E7Ghmrrwed3Nvl+F+YIHLfqmTVqL7pQhKW8=;
        b=XEpUI8hIx3X+6kZ3yylv7eIeIAAAEYpsSpz4CGQ3qSE+tvSqwAgNp9I8546K9dQZYx
         lluWl4FOSVPjUCm7AKoZCtGyIghb9Bj5m5/rtXCt/l59s4ZIoDsc2Lgc6G8Kj5zJbWJk
         D41THRpHTp5NX1W8LgykJyhngQ/SNcbzohXVY8NoYq9PSDBUUNsiHpux5msNP2zXzIDT
         v3emLO6qdg8Ve4J87imbQBAIYpWV0JRfI1km0lrbiey4zXk1/pDS+DuQ0tMPufPjVdHn
         zxTGx9+3rrqcM/nCrsMgjt+1K6tFF1hPJ451FIftAg9y5FgRhZg16c2qp2SNqmGdP9WQ
         9/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886995; x=1772491795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UlvuMA+2E7Ghmrrwed3Nvl+F+YIHLfqmTVqL7pQhKW8=;
        b=i50s+tXHCdPsNYi6trRNV4GfgWGrDd/VjRlxgsSwK8S0oE2Si5mBjX/0P2oXXiUaJI
         gqfn/PYhIV7acg8kLkETW9iOlvSAaqkXcx5Yxmylp71S+j5Nbd5mP7A/xb1YMotMgLtC
         fVqBMAl6U2F8XTSdMI2L/UkPzFm6n8uBv7N3yGdjd/Map/p8xLyL8wWK3ReBgnTGaUEm
         PNsGnTnjR3PEE0iJVIb+hzxO3cuNloPkoO8yd5+moeDnDKGEl4KBnxM8p+okoOpqc8yW
         N+nh4zw7PEpTlK/1f3MYeL3k7wFNA6Czh5AoxPWhAkRmqzF4QD67yuthQyHq0gZNEFJI
         YGbA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSdhEA4bz0ysz5PJPm9WFBA8ouEJTQ7udNjm0WD2dT9w2giIjf8Qm26rCOzCbVzuFs9b1ICX8REw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTe+gpZjmIgKXWl3egB/aERTvljpqbV52fD//Hvw1O8FPgq/0+
	SN5ajcc2Sk0me4Ss2DeosZ5JqKKFKrzK+Q7z2YATdyNrNCRi7Q5+H3G7oohUv+51fIc=
X-Gm-Gg: ATEYQzwHcJ2GhWfC6+WYPR1hRQYBPyitdfyq2UoOU72lPoiXVeTQTvmWhU0eElkydD4
	cwp/qMp5v9Rjph4XOaEYUT0POOv2e/khQ+d+9ja1pV8canmMH7oaW+HTDmddPsUwxKG/JYDzB4Q
	AubxdIhPoLPtaGQUCH8qpNvnlXM1Qcx0+QDd7uNAaYMzC2Fcyp7s9BydUV0waaoJXGZdChfrBGd
	Y/b8JLdiESVXBt0Ic17tQVKlRCpOQZvYk5pk1/SJ7f9Dsi1tTpOo1yE6OxIDSKc1E/tf5oxW0qU
	dMFIY3/2m04KITh+SqIPVQJTAKCVYEk2QyIEabqlzaTRrRiLSYJ575IMo88RpLAiXLzswzjlc1e
	XCPXDX5IQ2/+uLzIoU8CmBUR6uCxJxKxXy1JFKxSa+NgR6k0Mg4msjPuiuIGMeTqJlV5gEAriPz
	QEHPjOtBeNiyba311xdW9jvt4SPVbAL3u8eNbSopjvRFN5XoUGvxbtwfShMQMn+hXX/QPRjDIYT
	OwewUqBCLTLEKISkwkyQhW5Qus/NS9HuXprXFAxaNVj+vLs4PM=
X-Received: by 2002:a05:693c:2d84:b0:2b7:f0a0:c195 with SMTP id 5a478bee46e88-2bd7bd2721fmr3645670eec.31.1771886995216;
        Mon, 23 Feb 2026 14:49:55 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2bd7dc35362sm5537678eec.30.2026.02.23.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:49:54 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: ahuang12@lenovo.com,
	alok.a.tiwari@oracle.com,
	ashishk@purestorage.com,
	bhelgaas@google.com,
	guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com,
	jiwei.sun.bj@qq.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	macro@orcam.me.uk,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Mon, 23 Feb 2026 15:49:49 -0700
Message-ID: <20260223224949.31354-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260223173603.GA3698515@bhelgaas>
References: <20260223173603.GA3698515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wonder if the compromise here isn't adding a new kind of 
DECLARE_PCI_FIXUP_<LINKFAIL?> & putting this quirk behind it?

On Thu, 19 Feb 2026 16:53:22 -0600, Bjorn Helgaas wrote:
> I would like it much better if it's possible to limit it to
> devices with known defects.

On Fri, 20 Feb 2026 12:03:17 +0000, Maciej W. Rozycki wrote:
> As I say it's logically impossible to figure out whether or not to apply 
> such a workaround where the culprit is the downstream device

I don't think we're looking at an impossible decision to make here in terms
of whether to apply the quirk. It makes the most sense in my mind to restrict
the quirk to that Asmedia device which was upstream of the pericom switch in
the initial bug report iirc.

1) There was never a root cause so we can't say that this is in fact an issue
    with the pericom switch... It could be the ASmedia switch causing the problem..
2) Even if it is a bug in the pericom, applying to only the ASmedia switch limits the
    blast radius of the retrain action. It becomes unlikely that we ever see any
    reports of issues from large scale users (hyper scalers, server vendors etc).

On Mon, 23 Feb 2026 11:36:03 -0600, Bjorn Helgaas wrote:
> IIUC Matthew [1] and Alok [2] have reported issues that only happen
> when we run pcie_failed_link_retrain().  The issues seem to be with
> NVMe devices, but I don't see a root cause or a solution (other than
> skipping pcie_failed_link_retrain()).

I don't think the issue is really specific to NVMe devices realistically what
is happening is that NVMe devices happen to be hot-plug'ed way more often than
any other kind of PCIe device. Vendors who design devices/systems for hot-plug
will also do extensive hot-plug testing & due to limitations of the kernel's
heuristics, invoke the quirk when it is not desirable to do so.

-Matt
