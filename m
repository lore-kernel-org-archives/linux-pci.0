Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from newmail.cct.lsu.edu ([130.39.21.13]:53735 "EHLO
	envelope.cct.lsu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757154Ab3EXRdo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2013 13:33:44 -0400
Received: from localhost (hermione.cct.lsu.edu [130.39.12.224])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by envelope.cct.lsu.edu (Postfix) with ESMTP id 9188D205844C
	for <linux-pci@vger.kernel.org>; Fri, 24 May 2013 11:59:49 -0500 (CDT)
Date: Fri, 24 May 2013 11:59:49 -0500
From: Bryce Lelbach <blelbach@cct.lsu.edu>
To: linux-pci@vger.kernel.org
Subject: Patch: Increase maximum bus memory window size (for Xeon Phi)
Message-ID: <20130524165947.GA2487@pyxis.br.cox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--uZ3hkaAS1mZxFaxD
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch affects pbus_size_mem() in drivers/pci/setup-bus.c. The =
patch
increases the maximum memory window size for a PCI bus from 2 Gb to 2^63 Gb.

This change is necessary to support Intel Xeon Phi co-processors. These co-=
processors
are PCIe devices used for high-performance computing applications. The devi=
ce requires
an 8Gb memory window to function (the co-processor has 8Gb of onboard memor=
y).

This patch is a modified version of a patch from Intel's MPSS framework
(specifically, from the "KNC_gold_update_1-2.1.4982-15-rhel-6.3" package), =
which
will apply to a 3.7.8 kernel (I am about to try it on a 3.8 kernel). To the=
 best
of my knowledge, newer RHEL kernels are shipped with this patch.
=20
--=20
Bryce Adelstein-Lelbach aka wash
STE||AR Group, Center for Computation and Technology, LSU
--
225-317-3866 - iPhone
225-578-6182 - Work (no voicemail)
--
stellar.cct.lsu.edu
boost-spirit.com
llvm.linuxfoundation.org
cppnow.org
--

--45Z9DzgjV8m4Oswq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="linux_3.7.8_pci_xeon_phi.patch"

diff -u -r -N linux-source-3.7/drivers/pci/setup-bus.c linux-source-3.7-xeon-phi/drivers/pci/setup-bus.c
--- linux-source-3.7/drivers/pci/setup-bus.c	2013-02-14 12:57:59.000000000 -0600
+++ linux-source-3.7-xeon-phi/drivers/pci/setup-bus.c	2013-02-20 18:08:16.000000000 -0600
@@ -852,7 +852,7 @@
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
-	resource_size_t aligns[12];	/* Alignments from 1Mb to 2Gb */
+	resource_size_t aligns[44];	/* Alignments from 1Mb to 2^63 */
 	int order, max_order;
 	struct resource *b_res = find_free_bus_resource(bus, type);
 	unsigned int mem64_mask = 0;
@@ -891,7 +891,8 @@
 			/* For bridges size != alignment */
 			align = pci_resource_alignment(dev, r);
 			order = __ffs(align) - 20;
-			if (order > 11) {
+			if ((sizeof(size_t) == 4 && order > 11) ||
+					(sizeof(size_t) == 8 && order > 43)) {
 				dev_warn(&dev->dev, "disabling BAR %d: %pR "
 					 "(bad alignment %#llx)\n", i, r,
 					 (unsigned long long) align);

--45Z9DzgjV8m4Oswq--

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJRn5yDAAoJEBLaNmtPI4b8EF8H/0pOEsG07Fm+OVc0xUUpAd+a
WxlaaE7SyIMivaj7dldd54si5A0bJuslJDh5HMFUmYewSk8LOuSWrqetGqWc+m2E
jBjRMu9I4A4y6yx7yu6VgfD8QscCrOtHkGEEle1VkPaRChNqjB77+pFSQx/Zf6hM
0kGrfT+460fQ8mcEWT2soA1PWIBmOpDY8LxwKJEhxnXzo93m2ibHcyprsT/bQRB6
1kkexgl/EeR5uUZ66ogvh0HCoP0nf0Z9zKAmieHd0L4ahIYY95eABvxpuTBsuCjN
xpxJiBZV/LvlNJyF2A90ZW9/To6LbSdTnJoJrRzUPhGYCXjRsbMWtJiE1pzAt8Y=
=UvL2
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
