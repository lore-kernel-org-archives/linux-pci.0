Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FF340A4D
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557841; cv=pass; b=OC7VWDINwShywPRWv0zh1TJoZAJo7wveb9AcJ2z7qpmD/4TuQrDv8i0oI/17DNOppO1TileWCb8pB1xyfpaKju3mruDeZeineRuRHRPpBhvZVgGldzSefiJCYMoAQa1FMI6OSUi0nHmTJX/G6yZx/II1L9OeSVi8x2vaRx+JKgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557841; c=relaxed/simple;
	bh=PeaSOVbGjvcbPrM1ej8GhDm0pQojiKvmqm8K/+z+B5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRfdsfWqkKPeoakbfWPJUkSkNHVIqSXApQm9BIakK79J1D1QiXGzvsWeMNlzhUoUqFK/yc7TAd6Tk0htopMS97XrKXwSP4DqP5oNmSLZo8tgcdGdqhiGFiamHLFdzOyqSVGTr6ZR+zwlKGe1cHuNMg/9lTgGYNZ6ImIZ6hJGh0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piX9Xtl3; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piX9Xtl3"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so1660830e87.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 13:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774557838; cv=none;
        d=google.com; s=arc-20240605;
        b=dYdKoW0WH1eN17DjlBdq7YDp2VSNPWnChsfvxaTK4BXAytnF7xQLjd4jcmHcFgo5nY
         lRcpmkh81SPeByqAcD/GE/VI1ioTpArEfNpAmHl3hf90Ar/qL0HoMTt1epgNnXL4Hvna
         y1o5NA9bJNnRCPiZei1edu6qCKZqhkCxXOjs9zIqdwFmRi820OJ8DWkbL9N7HpYVs32N
         gBdclb0kgaHkcqZd6ItNYCJ4XEuEl3TWxyDdJ8h3ulpcBN1befrq9SDkStI8NDyuYybF
         SRZfEODLqDXBVFoINv9iEFBlKP16uJsAGB8uqxW9k3UvBGoM453yLF1LdJ5sUFjpkVYT
         bCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        fh=i2meigVEQAnOXGZzyTNs7KLZrMBdqDH5BTzmMY2QL3o=;
        b=ee7pOhXYT3UgJEMt4Jgpr++t+Avy4nUEHliXAC1wSPnwLwWIX4qJgMhhRo9py7fmV3
         zufYf1IfHF3TStMpPdkVVpiegkO5iG7eELKfVnWRMnof3My6bEw6lizrzHX8HaoZ7E44
         7nOteJObM+W+Sa7xv4Q9BKyke8IMazo9R6uxMeCBowjufe75Qvj7ep/rsEcWFhG99/QM
         sjM/engVsFRvDCqX/f8DG3Mdv/KHH92n+L1nvCTdK7dCBFY2W1DpWuIDKFCGs9Ud3Eti
         qEmdGYHoNfWo0AczRfcJKEzqd3Yt8AdHPqiedKQkwzVMK6GrzX6f6mGIKZlXCYzr4AWb
         rq4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774557838; x=1775162638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        b=piX9Xtl3iaNv8uRfxNguwwZybMuQycDIDPJDH0KJMJLN8uO4MO9qljp+6Um2fxBy0W
         DvbbxR72etHfe2JSvVkW43pq0jujJGTwdK6ZIn9fYJxI0JEyQIpzWNhFE+UPxqAXCFOx
         muZ4ven/Q02Rnfe0TNN5n2BfIDJfc0qu7dlulBOX+4IMwpRmLZHE4SKf/IolDO2ZGwry
         SzjXwCdA4gxJYubVTk+stqy1YCCmBeW+ZAgNmOUYeO3y2mXlphgmGYGEPOoUqpKw5HpR
         Ie5nuyrjnlTAW7NHJdpmZrOjV/IfjDvFPmsknTUTQ/VJT8MbysYMuKN1aoCVotxvyED7
         uSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557838; x=1775162638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnD4wGwZvJQvR/a6rbd+FFqGbZMJuBdhvv8TVCrH3ik=;
        b=oIEvhTSuXB15FlCIH3fOR6phfQnSC8ESfJpXkKWZT6b3OC77dkBkGxm0NTFy0/hqwm
         Z9od6WS1LYN1pfNBML+8Ilkonxh6CQwZBo8Japq4zzBXj7tiT8NZzAWGI3xQ+KzCFEZn
         HLdULN9QrwcsSi0lds1vhBOTqjoywyN8qYqXzDpDExnqIxFxLJEvq0qZsT778G5wGdyU
         gOm0YujYde4xq6Jdfx8WbqG5tb3oemBvrVM8STphMgLA5hSXP9Bs3m+6CJzawf3L9dOJ
         FkH4aQ5Cpt+BSAPf//KtmEeEeg2rhYH3aFcm3VuLn4OWloCZ0jACicdQ8Rn7IUhWOiNv
         TOmg==
X-Forwarded-Encrypted: i=1; AJvYcCXf1MeYhviRf1mafW06y83uurqfLN1dvotbkMuk6Rimz1uoWTE0iTzezgPRbz1jLiZJzN4MGqQQkEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzox35dk+dR6zLZUKSFhGQUxwjZtRcxA6GsmNB+AtYAjjAXM2fv
	XQw1r/2OFPvNfPGLmFd9rijXHH/0qsaOunmvFLujXz3YGzdStmnXNTaamSItzvmA+P9ieM84gDY
	ayIFMlJ66jKxdy8CVGbftpRsiQHW3PprxGDGh1fsN
X-Gm-Gg: ATEYQzwWcXFfLmlbKvNsA1AVqPHy09zQIYiCNUQGTQJBp/mkPxNhDsHd5XLUlAiuX6t
	K30PdTTjJQLYybNyMnvSCxiG3JiMXQTedlgnwSbJR5swgzPzRJZ4ag1GNexVW5VpRFeMTr3ij15
	cHpudtgyYj5XIvKEiW82SC1QyKSnmpEO3GzT7Tp2yCDlgbkWFZn+VEPO9+hr1vK9PPwButDpxZ6
	zwcM1NpWYldv0A7+sSzMXqwu8Gbu61S0v39tN3GQmuDyikEGGWufKOv/o532QuJz6oPGnvoqwbP
	PbVnZMn7
X-Received: by 2002:a05:6512:10c6:b0:5a2:a5e0:2da2 with SMTP id
 2adb3069b0e04-5a2a5e02ec7mr1094413e87.8.1774557837156; Thu, 26 Mar 2026
 13:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 26 Mar 2026 13:43:29 -0700
X-Gm-Features: AQROBzDv95n65Jfr7km6DKOoUBuRrbrSOHrGu-gele9pXf1C5O1laHd_UCbivjU
Message-ID: <CALzav=f4--Kp5vXz5zrxZR3WVsa9T1GF4NFFtuf_Q5ESMHmWwQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO
 device files
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> This series can be found on GitHub:
>
>   https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v3
>
> This series adds the base support to preserve a VFIO device file across
> a Live Update. "Base support" means that this allows userspace to
> safely preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
> and retrieve it with  LIVEUPDATE_SESSION_RETRIEVE_FD, but the device
> itself is not preserved in a fully running state across Live Update.

Apologies for the large number of people who got added to the CC list
on this version of the patchset. The changes to
Documentation/admin-guide/kernel-parameters.txt in patch 4 caused
scripts/get_maintainer.pl to CC a number of additional people due to
--git-fallback. I'll fix that in the next version.
