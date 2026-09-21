Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAD431A3C
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010487; cv=none; b=ipEM6ru6sTr2ong/RRouDRyXePH9iOT8ywf1G2aRZnKs8W+zAV+KXFEtX5MJBVn/kcF7Ns33Ix8Se5/XCvTdqAyzuHF5woKi4bB2nY5deYDfCHMitQvf5LzPpn88dQcq0e32gnVvRMsEpOUWpftlLfAMt/6zPfZcazFnMYEfURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010487; c=relaxed/simple;
	bh=xYX1ubJhvytFImf54qv1amtx1iuj6c3isZxDG2i6+3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKZqcJMPhkc7fh9CoCNter56iFcBrTZM+8hMs2CXQUyPm5HcdxkM5ne6R9by9rL9F4UWvWtxVXsMicjfg18quPj/w7ex/MOpMKM3Kmsj8SGC/GnnMQ2viRYl3iNHKBK5anmJEZE2wWJQm/5sHj622UciB9XoRD7iINjmgHuhj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dVRRcueI; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dVRRcueI"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso4737727a12.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1790010484; x=1790615284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbBgwtddF+Rmb5mXPYMuNZ3XqvUCZVCRhQupANAjEM0=;
        b=dVRRcueIXEFTPx+UyoQpXBWrYS/bq1t6XkR9iUV68JZSfOZ3JyEbwqUAt7Km0wfW+b
         +vvCYfJO0Tr5mBHJPVLsrROuEG4O1oQtTOtJrxDS9OLamopNY4kbJ3Yd72AhpEGU0a1J
         WksbchqTWiKQDoy5QmeSoGjdlNWK2yy/ThOLAUgd72B2/V7kih7mOucdpW7dMPWa16RK
         NUu0JJH9h2DdWo0N4iXFpz4EJfm/RKETCXqwiHxPe1sYm4ayQpI07x1exbeZ+DIljuS/
         jDoePlNoAKddatQEjqLT2RUYOrZbv5gZYYZain6QfSHwTNTc9ps6qSYvKklVu7PPCwFj
         1uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010484; x=1790615284;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbBgwtddF+Rmb5mXPYMuNZ3XqvUCZVCRhQupANAjEM0=;
        b=ng+hGCBerYLnziHGH5HckyauVWbSn0q9NzmRpkpiiV9H3woKUm7yd/TW36phinXnsG
         l5VwpUGhJzgZRoVRTQ+LHShZ61bo7tQvuVSQ+3oNWG1IEgcdu75gtfK5p8+lwBCPyWLi
         oWZU3A90vEBWwMj47DHKsWMD5gdeGEb7j912v6yAtJ/ogQcY8hhs92NfEHOIxYCfuZ5R
         CODX20M33GXk0QcxSEqr51zlZbLstWotuP6sGV8mFMQUv4WKo0EWogupp+Gz2NdTNVmQ
         yo49LFhGrMY064Rkgsk/GqKtmudbcATJ3gmEnWqEvOeoq4k/H+C8JVEclKLAi0tyigXn
         SK7w==
X-Forwarded-Encrypted: i=1; AKwUvBw57x8VWDBX2fXXGCJ4ovYM9yFNzuTNwxczsoQjPOexLsLk/D/cWy9XXFP0EgAUi2IQO2qL7OF5tnU=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ1pu5OPazxvd0fbMRgL6mfEetnzzB3I7NeWPpAu0j4TmREEHi
	8YeyRRca7dmWIlYB9BiBIiEe2UAOx8VX7/ws8s8twIlPz4a5yv52jdc4u7/huzITSw==
X-Gm-Gg: AYBFou26/poim1g3apUArbtTQoy9kQ0KKTBlPmHX/ei4wSy3YdS6wal6OgY3h0l+hae
	noFrBJCvNEhd2I8TS4t4FUTxlvgkvVOYrk4PFoZa4mUZr4qzpkaSTiSHJwY3MeHutBx7H2qa0mI
	bc/ZN+KrlX3itbGKgoKbxe/a4OJfhdgKAm+WYNPhqpz4JYOY+zfgrkmf+bWy8AMDH32/IiE+1JJ
	0Z0uwECcaLELP6hDj/l1BOZK1xu3ikMHnEpDXr11FkSGC7Pwr+mQEz3eELE+gXkGdMFPlWUQEGZ
	OjKemrbf79KDY9UBK8F0g9oJCJMt1EHNBsa7J9OsIgNZUlx6CUmNFyFoEkEFPSJlWSthLKMpkyY
	0yPHc4eBhO8W3fudYbissOVxawJVDcfBZjfm6em8DlTrvdZM+QskyAOg5wXmcU0j78RiZQRDGgT
	NmmgJBq79rLj45l2AmDyHDg0gcWase+RV5LNBnaOflG62enDM+xZDBcI6Hkeg7XTqjcFex2QapW
	nXkstGuqGEX05JINb/9pB/iGuCQdWIyM31RnfaN0YvbGCniKIprjeA=
X-Received: by 2002:a05:6402:460c:b0:6a5:f692:9c3a with SMTP id 4fb4d7f45d1cf-6aa53156915mr7823289a12.1.1790010483877;
        Mon, 21 Sep 2026 10:08:03 -0700 (PDT)
Received: from ?IPV6:2a02:8086:c99:c280:94ab:79a9:2843:6b2b? ([2a02:8086:c99:c280:94ab:79a9:2843:6b2b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67daf380sm4698964a12.12.2026.09.21.10.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:08:03 -0700 (PDT)
Message-ID: <c52cc96e-b40a-45be-be9d-775ed3dfe3dd@arista.com>
Date: Mon, 21 Sep 2026 18:08:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Sewart <jamessewart@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
 <apq3kd9_qsURNpKu@wunner.de>
 <6f916404-63b5-40a3-a429-befe42a08629@arista.com>
 <apvpr5Q6gu_3MODj@wunner.de>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <apvpr5Q6gu_3MODj@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/26 11:06, Lukas Wunner wrote:
> It's repetitive because pcie_capability_read_word() already checks
> internally for pci_dev_is_disconnected():
>
>    pcie_capability_read_word()
>      pci_read_config_word()
>        pci_dev_is_disconnected()
>
> I just thought that since you specifically want to bail out in the
> hot-removal case, it might be clearer to check pci_dev_is_disconnected()
> in pcie_wait_for_link_status() before performing the config space read.
>
> But I don't feel strongly either way and checking the return value of
> pcie_capability_read_word() is a viable approach as well.

I've sent v3 of the patch, returning to validating the 
|pcie_capability_read_word()| return value.

Reasoning:

 1.

    I don't see any benefit to using |pci_dev_is_disconnected()|, other
    than your point that it makes the code clearer or more readable.

 2.

    I checked how we set |pci_dev_is_disconnected()| now, and it looks
    like failed reads don't guarantee that the device will immediately
    be marked as disconnected. I assume that eventually we will receive
    a link-status-changed interrupt and the device will then be marked
    as disconnected.

 3.

    On the other hand, |pcie_capability_read_word()| internally performs
    a |pci_dev_is_disconnected()| check. So in our context, validating
    the |pcie_capability_read_word()| return value is more robust,
    allowing us to react to device disappearance (for any reason) faster
    and more reliably.

  Thanks
