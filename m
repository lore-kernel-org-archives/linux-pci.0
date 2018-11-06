Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3268C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 08:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8848A2085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 08:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbeKFSIG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:08:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:7966 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbeKFSIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 13:08:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 00:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="asc'?scan'208";a="271729570"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga005.jf.intel.com with ESMTP; 06 Nov 2018 00:43:56 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: quirks: Override Synopsys USB 3.x HAPS device driver
In-Reply-To: <30102591E157244384E984126FC3CB4F639A0308@us01wembx1.internal.synopsys.com>
References: <62f746c341ea00ccadda47c3cb02eb57f2e90db2.1541209477.git.thinhn@synopsys.com> <8faa039d80ba1f8ab2c7192a237ff8431d5cdc4a.1541209477.git.thinhn@synopsys.com> <30102591E157244384E984126FC3CB4F639A0308@us01wembx1.internal.synopsys.com>
Date:   Tue, 06 Nov 2018 10:43:51 +0200
Message-ID: <87in1avbnc.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thinh Nguyen <thinh.nguyen@synopsys.com> writes:

> ++ linux-usb
> ++ Greg
>
> On 11/2/2018 6:47 PM, Thinh Nguyen wrote:
>> Synopsys USB 3.x host HAPS platform has a class code of
>> PCI_CLASS_SERIAL_USB_XHCI, and xhci driver can claim it. However, these
>> devices should use dwc3-haps driver. Set driver_override to dwc3-haps
>> for these platforms.
>>
>> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>

FWIW:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlvhVEcACgkQzL64meEa
mQY3iRAApJVbJS5Xa5zjmo0pL+I/g+PZh62n94OYkZcQDSCkJ1G462R49eA5J+5D
WeM1y605r4GXq5m3GpUQbRG2hlwqzIUQN/h6zd1k8pXdNZEGCV4MFtXIygigMI6E
WsIWdZM7r1xahSmAZ3YmumT2i2zjHrswXSmDqaIrT2y4tnPfvV24ZIOnwMD073xL
JvShjAE1XYxfXvOgb/h0WMlPWqcGeQlEmzbVbEzvKw2vg3ENuk8qnV1yx7VV9CV5
7H69pkxGa+cBfiw9dijCsjXt7g4/Z+ZQUdZ4W5jSYVmn2O1SfCzyoLuDLGWQwK99
X/5wXuOtFetR2KFwhuBsqoyI+bYtFPH/xP78bqPZd2KOcosHO874HGDZ7e9ICIV2
Mq5K0RVLFYV1oa5eOIOuqW9C+pcdWIhShZmoyZL0YhTZMZ9Mp9BG7Xg4PfxDpbNm
DVjol3/5bd7JMawZz8Op6Lklom31rhjxaO8eyCGAxl4qAFgKjo3TGeRC9Gble0Bd
U+/MY8Zd1GlM+I/UmKGNbQsyfFA51PQCm9zFKd7b7cnPW7xzTFucqy8EtMerIBCc
e2TnDKg7Jv/s2YmxuAuV84eEHgwjkFhiLPTUYLJYYv1P0FHem46G9M2R5kQmocXd
0h2sl2po7lI7mZ5rgBuwOkRW/dVvn5bwQRZvoHHpT242qW/a0gs=
=MUuk
-----END PGP SIGNATURE-----
--=-=-=--
