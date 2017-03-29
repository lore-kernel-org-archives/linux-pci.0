Return-Path: <SRS0=US7a=3G=amd.com=Kelly.Zytaruk@kernel.org>
Return-Path: <SRS0=US7a=3G=amd.com=Kelly.Zytaruk@kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Alex Williamson
	<alex.williamson@redhat.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Subject: Having problems resetting a PCI device
Date: Wed, 29 Mar 2017 19:57:40 +0000
Message-ID: <DM2PR12MB0078B2FAB74BDC51429F7BBFFE350@DM2PR12MB0078.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_DM2PR12MB0078B2FAB74BDC51429F7BBFFE350DM2PR12MB0078namp_"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--_000_DM2PR12MB0078B2FAB74BDC51429F7BBFFE350DM2PR12MB0078namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a PCI device that is sitting behind a bridge.

Under certain reproducible circumstances the PCI device will become inactiv=
e. Reading the PCI config space returns all 0xFFFFFFFF.

The bridge appears to still be functional. Reading the status from the brid=
ge I see a Fatal Error due to a Surprise Down event.

I am trying to figure out how to bring the device back online.

I tried toggling the secondary bus reset bit of the Bridge Control Register=
 but it doesn't appear to make any difference. I still see 0xFFFFFFFF in th=
e device config space.

I provided a pci_error_handler but the error_detected() function is not get=
ting called.

Given that these two methods are not helping me out what other choices do I=
 have to either reset the PCI device or hot-plug the device from a kernel d=
river. Or some other method of bring the device back to life.

Note that I am running Linux 4.8 in dom0 on Xen (if that makes a difference=
).

Thanks,
Kelly

--_000_DM2PR12MB0078B2FAB74BDC51429F7BBFFE350DM2PR12MB0078namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I have a PCI device that is sitting behind a bridge.=
 <br>
<br>
Under certain reproducible circumstances the PCI device will become inactiv=
e. Reading the PCI config space returns all 0xFFFFFFFF.<br>
<br>
The bridge appears to still be functional. Reading the status from the brid=
ge I see a Fatal Error due to a Surprise Down event.<br>
<br>
I am trying to figure out how to bring the device back online.<br>
<br>
I tried toggling the secondary bus reset bit of the Bridge Control Register=
 but it doesn't appear to make any difference. I still see 0xFFFFFFFF in th=
e device config space.<br>
<br>
I provided a pci_error_handler but the error_detected() function is not get=
ting called.<br>
<br>
Given that these two methods are not helping me out what other choices do I=
 have to either reset the PCI device or hot-plug the device from a kernel d=
river. Or some other method of bring the device back to life.<br>
<br>
Note that I am running Linux 4.8 in dom0 on Xen (if that makes a difference=
).<br>
<br>
Thanks,<br>
Kelly<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM2PR12MB0078B2FAB74BDC51429F7BBFFE350DM2PR12MB0078namp_--
