Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340A3A875D
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065575; cv=none; b=GtYczCHqnpeYKBbR4lxMPIv+jhzN8iHVkvHc6q5ajPxGgDYGBUXdmQ+r4xugLXSy5a3a9mE5ys7szeIsuptvjEvbj73IhXoTWO15o6fY916AoOgDqmGhn9EJ8PPggEaE/AAiQMMkmCMUuGrzBX1SUGjjqkl3Vw/F/nTkZ/9pkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065575; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg+enhqkYTCGFgYbEYye72p/5DR65polhZ85mrJjmGpMKUgE+vbOqGzljWrW6sA4gY7AWOO9Gie/AEj7HNXwh40ucCkW8RMBkDaPRHDUN2MDYay2G0fV8ORuLdppqdbFCbcXdW2Qoi+kduW89gphW7RJrBaVZkfY4jilyTUtJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=UcKddbKk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="UcKddbKk"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f97d310caso1229983f8f.2
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065568; x=1785670368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=UcKddbKk+nkVTNd4kHsgAnXK+qu3602GkP3rsgzCLowWckJGUHML6/5jd1eQHErJv/
         SJV+xgbmbhpJbF8pxkBMpmdz2mxqUp0d4gfJZNyeNO7HSLV70Jjh5s1OLtjELA5Q7OTS
         MVclHgcL8qyU6s23t6NETabRZJorB2CdYaWL3S+6K7d4LmiAxn66bJpQnM8dXIK7/ajL
         gvdcMDsVQFpihPUj4XHQWDuGNp13dHMxHde4/ZduK5ji3SfPQlBZDpthP9tVlpaf6qBY
         85MD9Io6JiJ/UlyNC7ELTED36z2Gxwu+Z2WqzbBzPzYyEgzQAPzvoi4Kx3GWDZfXSLKS
         9TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065568; x=1785670368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=Ol9os8gkaqbD9A0XwamjT0bsljpZ3odFlko8IaiTT/n5wpFuSbxZIO/kzZNVkM13Ru
         vdiuhYwCUoCmC4AKTWAaIsyAqCJlR4cRo+2rVEswgW6b0fNpamlD53Mx7E3o0l2M9n9i
         EGdGVlmzzEzxF7fQgz42L6MTTwOKNhRNFk9+/stuGzskZwx9pqJzDLxDAD3hY2ZzB//v
         R+Kf9SoI087uvVDlPHPD9jC/1eVG9BHQYKX78WXcOgG1MZm3cvDtQZ4GKCe9a3d7l82G
         ccYGLbGsRns1ExCWXwKGjGT5KgcYADofZHGUdlANmhkCexQouEtZDt7S9voahaf9NZIL
         h5Cw==
X-Forwarded-Encrypted: i=1; AHgh+RrG+4Qvt+ubZiMAGZd3SYhJ9Gow1T/KUJZH5EVL8EXzz0zrDh6mSl7Xi3VnP1mQg2OCHA02KaVYeLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3gp22A3EI51EFxojQpcq5maG7Vbhn2Ic/AMEJPNKihCir2dn
	KTByg2uPkEj5dkbTO4xiYdGPWYajayvsLzerp41Wy5l8jbsd6kcFK9ZaPbG4pkm4dA==
X-Gm-Gg: AR+sD11uB4nPI/SFULqDz1VXYYml3o5V9B4ZbaJvVQPCxmVwr901q+Kq0dNeCztE8mD
	Slh2RoQtGlIBeMs2PdNxCBIX/XJb+EyGHnVR8DWmqQ7DKG6QrzGLa5CCtv932JR1ROQNvcUlknS
	WlyfzH48D4kJmzZ3ZxTdDDhDPyNbh82SzYW1aa2XIbgjXRNIMND1xsCo6w7QEwmzHMzPkAvAa5f
	OsYIPzoFDzViAsfEIV3VK5Lkv4PrzZwqp7jNmrCXPIMB4K2X+bB/laPRaJaO1JX3crp1qbMK8G+
	UA05VJtfFtSM6A/aNJoYILd0M3a/ZuZJnnf6ddQoFa6y1Z18xuqCNj5sgldhTUxP70NOwrHkRee
	DXgJC0nR/2fqI21Yu+tAbw9RGJf89a0dYYyMY20jEBMF77Fc1eczRSDJ6Y2vn4uDlDrG3mbx8zx
	Whg6/ac2JSM3ENygBEMxCBdMibc7D7B28EaTl511DxUOT1Go9UjtdOhk5FXdzp5Vo1/vxjL5VA1
	47gNPcCPb+IvD+Sc+WLG2Zp6sgvCgnPuK26atZ/R9O8dwqGAus52JKZ+324vRum5QGVm/MYEhyR
	3z++ngC6uRUTtaysMlZfeYC6NEYjKbaXXAQ=
X-Received: by 2002:a5d:5d09:0:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47f9fe9e8bbmr5988536f8f.36.1785065568316;
        Sun, 26 Jul 2026 04:32:48 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:47 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 06/12] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sun, 26 Jul 2026 13:32:23 +0200
Message-ID: <20260726113229.2154269-7-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f07edeac6e5a..19c4dec450de 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2561,6 +2561,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5b63175fb382..428bddddfe71 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2823,6 +2823,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.52.0

