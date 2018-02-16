Return-Path: <SRS0=oV23=FK=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=oV23=FK=xilinx.com=bharatku@kernel.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>
Subject: Multi MSI with multiple End Points
Date: Fri, 16 Feb 2018 14:46:11 +0000
Message-ID: <BLUPR0201MB1505FD30C348815427BE6606A5CB0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_BLUPR0201MB1505FD30C348815427BE6606A5CB0BLUPR0201MB1505_"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

--_000_BLUPR0201MB1505FD30C348815427BE6606A5CB0BLUPR0201MB1505_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

A switch is connected to an RC with 2 EP's, the RC supports multi MSI.
1st EP requests one MSI vector, 2nd EP requests 4 MSI vectors.

If we are programming hwirq as MSI data (hwirq being obtained from bitmap_f=
ind_next_zero_area,
with number of zeroed bits being requested based on number of irq's being r=
equested).
This gives 1st EP is given zero as hwirq, 2nd EP is given one as hwirq.

If we use msi data to retrieve virq (use msi data as hwirq), Since as per P=
CI spec lower 2 bits of MSI data
are modifiable  for 2nd EP, if an interrupt is raised by 2nd EP on msi data=
 zero, but this is already used by 1st EP, so the
current EP's interrupt will never be served.
One way to deal with this issue is, using bit shift operations on hwriq bef=
ore programming to msi data
and at retrieving.

Is there any other better way to handle this ?

Regards,
Bharat

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

--_000_BLUPR0201MB1505FD30C348815427BE6606A5CB0BLUPR0201MB1505_
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
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">Hi,<br>
<br>
A switch is connected to an RC with 2 EP&#8217;s, the RC supports multi MSI=
.<o:p></o:p></p>
<p class=3D"MsoNormal">1<sup>st</sup> EP requests one MSI vector, 2<sup>nd<=
/sup> EP requests 4 MSI vectors.<br>
<br>
If we are programming hwirq as MSI data (hwirq being obtained from bitmap_f=
ind_next_zero_area,<o:p></o:p></p>
<p class=3D"MsoNormal">with number of zeroed bits being requested based on =
number of irq&#8217;s being requested).
<o:p></o:p></p>
<p class=3D"MsoNormal">This gives 1<sup>st </sup>EP is given zero as hwirq,=
 2<sup>nd</sup> EP is given one as hwirq.<br>
<br>
If we use msi data to retrieve virq (use msi data as hwirq), Since as per P=
CI spec lower 2 bits of MSI data
<o:p></o:p></p>
<p class=3D"MsoNormal">are modifiable&nbsp; for 2<sup>nd</sup> EP, if an in=
terrupt is raised by 2<sup>nd</sup> EP on msi data zero, but this is alread=
y used by 1<sup>st</sup> EP, so the
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">current EP&#8217;s in=
terrupt will never be served.<o:p></o:p></p>
<p class=3D"MsoNormal">One way to deal with this issue is, using bit shift =
operations on hwriq before programming to msi data<o:p></o:p></p>
<p class=3D"MsoNormal">and at retrieving.<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
Is there any other better way to handle this ? <o:p></o:p></p>
<p class=3D"MsoNormal"><br>
Regards,<br>
Bharat<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy,
 or forward this email message or any attachments. Delete this email messag=
e and any attachments immediately.
</body>
</html>

--_000_BLUPR0201MB1505FD30C348815427BE6606A5CB0BLUPR0201MB1505_--
