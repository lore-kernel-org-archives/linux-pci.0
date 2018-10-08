Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45AAC65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 21:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E3214D5
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 21:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mhBU+E8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6E3214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJIEeR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:34:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 00:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vnt1do4YxS+uaCcaWWFqQDEPRuupsxdACe5vS0zE6ZU=; b=mhBU+E8ZMFg+rEXby43lrEoK/
        764EQP+mS4VaZT0PhiWUHos5E5s4uFm4mDk5mZ+0yF33bDXVs5KtzZxn/ZECfNuisoTEiKIaSrDlQ
        XgsT79ZMOwA7+QNFgfOmHX2OJzQQwfrHZzSMn0w4UxufuO+t7plgbzNu4Vaj2IKqY95QA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9cwv-0003ER-Jk; Mon, 08 Oct 2018 21:20:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1EBE5440078; Mon,  8 Oct 2018 22:20:21 +0100 (BST)
Date:   Mon, 8 Oct 2018 22:20:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: next-20181008 build: 2 failures 22 warnings (next-20181008)
Message-ID: <20181008212021.GB4440@sirena.org.uk>
References: <E1g9cV0-0008Sg-4U@optimist>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <E1g9cV0-0008Sg-4U@optimist>
X-Cookie: Save gas, don't eat beans.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 08, 2018 at 09:51:30PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig caused by:

> 	arm-allmodconfig
> ../drivers/pci/pcie/aer_inject.c:444:6: error: 'struct pt_regs' has no member named 'ip'

introduced in e3fbcc7c4b130(PCI/AER: Covertly inject errors with ftrace
hooks).  This field is not present on arm.

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu7yhQACgkQJNaLcl1U
h9BDagf+LwPRL1t1sVSYizjg/QiHkEuWgCoDG/DCISn7+S4tmPq+RUckSydGDWeK
6XORa5lRRTS2XGO8xUbv09CSRpPmWvuUwGJVhXa6aZGpQvpyvM6DK3o05wzcwi32
KigMnayhssOWCdnPzyx8pRZNP76ljay+OPLIvNNgH2Ba3Zlh0kUFjz/9W13gHu9V
BQMi/ZQnGFoad3AM6EISBaDI9gZgvV4HCFOllWK+Jq9uwF7VPKppg0LXSxam9s2D
4Zp78RcALjdzWB7txKoDXJz7f9qRzg0EYDtAnYBzVUL3wPW8eBLcIUhaLOrrvZDq
RpUhMzKmeUhGRDxHCgHqD5MRj/4jjg==
=NAuf
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
